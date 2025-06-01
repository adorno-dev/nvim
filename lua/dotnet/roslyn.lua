local M = {}

M.setup = function()

    --INFO: Roslyn LSP
    local roslyn_config = {
        cmd = {
            "dotnet",
            "exec",
            "/home/developer/.vscode/extensions/ms-dotnettools.csharp-2.23.15-linux-x64/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
            "--telemetryLevel=off",
            "--logLevel=Information",
            "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        }
    }

    local roslyn_dispatchers = nil

    local roslyn_status = vim.system(
        roslyn_config.cmd, {
            stdout = function(err, data)
                assert(not err, err)
                local success, json = pcall(vim.json.decode, data)
                if success and data then
                    roslyn_dispatchers = vim.lsp.rpc.connect(json.pipeName)
                end
            end
        }
    )

    vim.api.nvim_create_autocmd("VimLeave", {
        callback = function()
            roslyn_status:kill(15)
        end
    })

    -- local function get_projects()
    --     local projects = vim.fn.glob("**/*.csproj", false, true)
    --     for idx, csproj in ipairs(projects) do
    --         projects[idx] = "file://" .. vim.fn.getcwd() .. "/" .. csproj
    --     end
    --     return projects
    -- end

    local function handleRazorProvideDynamicFileInfo(_, response, context)
        for idx, razor_file in ipairs(response.razorFiles) do
            response.razorFiles[idx] = "file://" .. razor_file
        end

        local success, json = pcall(vim.json.decode, response)
        if context.method == "razor/provideDynamicFileInfo" and success then
            return { generatedFiles = json }
        else
            return { generatedFiles = {} }
        end
    end

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "cs",
        callback = function()
            local root_dir = vim.fn.getcwd()
            local target_uri = "file://" .. root_dir .. "/" .. vim.fn.glob('**/*.sln', false, true)[1]
            local bufnr = vim.api.nvim_get_current_buf()
            local client_id = nil
            if roslyn_dispatchers ~= nil then
                client_id = vim.lsp.start({
                    name = "roslyn",
                    cmd = roslyn_dispatchers,
                    root_dir = root_dir,
                    autostart = true,
                    filetypes = { "cs" },
                    on_init = function(client)
                        client.notify("solution/open", { ["solution"] = target_uri, })
                        -- client.notify("project/open", { ["projects"] = get_projects(), })
                        client.notify("razor/initialize", {})
                    end,
                    handlers = {
                        ["razor/provideDynamicFileInfo"] = handleRazorProvideDynamicFileInfo
                    }
                })
                if client_id ~= nil and bufnr then
                    vim.lsp.buf_attach_client(bufnr, client_id)
                end
            end
        end,
    })
end

return M
