local M = {}

M.get_client_by_name = function(client_name)
    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
        if client.name == client_name then
            return client
        end
    end
    return nil
end

M.get_current_line = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)[1]
    return line
end

M.razor_language_query = function(uri)
    local client = M.get_client_by_name("aspnetcorerazor")
    local position = vim.api.nvim_win_get_cursor(0)
    if client then
        -- vim.notify("razor/languageQuery: " .. vim.inspect(position), vim.log.levels.INFO)
        client.request("razor/languageQuery", {
            position = {
                line = position[1] - 1,
                character = position[2],
            },
            -- uri = vim.uri_from_bufnr(0),
            uri = uri
        })
        -- vim.notify("razor/languageQuery: " .. vim.inspect(vim.uri_from_bufnr(0)), vim.log.levels.INFO)
    end
end

M.razor_map_to_document_ranges = function(kind, context)
    local client = M.get_client_by_name("aspnetcorerazor")
    if client then
        -- vim.notify("razor/mapToDocumentRanges: " .. vim.inspect(context), vim.log.levels.INFO)
        client.request("razor/mapToDocumentRanges", {
            kind = kind,
            projectedRanges = {
                ["start"] = {
                    context.params.position.line,
                    0
                },
                ["end"] = {
                    context.params.position.line,
                    context.params.position.character,
                }
            },
            razorDocumentUri = context.params.uri,
        })
    end
end

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

---@param table   table e.g., { foo = { bar = "z" } }
---@param section string indicating the field of the table, e.g., "foo.bar"
---@return any|nil setting value read from the table, or `nil` not found
local function lookup_section(table, section)
    local keys = vim.split(section, '.', { plain = true }) --- @type string[]
    return vim.tbl_get(table, unpack(keys))
end

M.setup = function()
    local razor_config = {
        cmd = {
            "/home/developer/.vscode/extensions/ms-dotnettools.csharp-2.23.15-linux-x64/.razor/rzls",
            "--logLevel=Trace",
            "--projectConfigurationFileName=project.razor.vscode.bin",
            "--DelegateToCSharpOnDiagnosticPublish=true",
            "--UpdateBuffersForClosedDocuments=true",
            "--ForceRuntimeCodeGeneration=true",
            "--telemetryLevel=off",
            -- "--sessionId=1f839afa-c288-4995-8148-48ca90456c6d1712425155204",
            "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        },
        trace = 'verbose',
        cmd_cwd = "/home/developer/.vscode/extensions/ms-dotnettools.csharp-2.23.15-linux-x64/.razor",
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "razor", "cshtml", "html.cshtml.razor" },
        callback = function()
            local autocomplete = require("cmp_nvim_lsp")
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities = autocomplete.default_capabilities(capabilities)
            capabilities = vim.tbl_deep_extend('force', capabilities, {
                filetypes = { "razor", "cshtml", "html.cshtml.razor", "cs" },
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = false,
                    },
                },
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = true
                        }
                    }
                }
            })

            local root_dir = vim.fn.getcwd()
            local target_uri = "file://" .. root_dir .. "/" .. vim.fn.glob('**/*.sln', false, true)[1]
            local bufnr = vim.api.nvim_get_current_buf()
            local client_id = nil

            client_id = vim.lsp.start({
                name = "aspnetcorerazor",
                cmd = razor_config.cmd,
                root_dir = root_dir,
                autostart = true,
                filetypes = { "razor", "cshtml", "html.cshtml.razor" },
                trace = 'verbose',
                cmd_cwd = "/home/developer/.vscode/extensions/ms-dotnettools.csharp-2.23.15-linux-x64/.razor",

                capabilities = capabilities,
                on_attach = autocomplete.on_attach,

                init_options = {
                    AutomaticWorkspaceInit = true,
                },
                settings = {
                    ['razor'] = {
                        format = {
                            enable = true,
                            codeBlockBraceOnNextLine = false
                        },
                        completion = {
                            commitElementsWithSpace = true
                        }
                    },
                    ['html'] = {
                        autoClosingTags = true
                    },
                    ['vs.editor.razor'] = {
                        autoClosingTags = true
                    }
                },

                on_init = function(client)
                    client.notify("solution/open", { ["solution"] = target_uri, })
                    client.notify("razor/initialize", {})

                    client.notify("razor/updateCSharpBuffer", {})
                    client.notify("razor/updateHtmlBuffer", {})

                    -- vim.keymap.set("i", "<M-Space>", function()
                    --     return M.get_completions(client)
                    -- end, { expr = true, silent = true })
                end,
                handlers = {
                    ["workspace/configuration"] = function(error, result, context)
                        local items = {
                            {
                                section = "razor",
                                format = {
                                    enable = true,
                                    codeBlockBraceOnNextLine = false
                                }
                            },
                            {
                                section = "html",
                                autoClosingTags = true,
                            },
                            {
                                section = "vs.editor.razor",
                                autoClosingTags = true
                            }
                        }
                        result = vim.tbl_deep_extend("force", result.items, items)
                        return result
                    end,
                    ["razor/provideDynamicFileInfo"] = handleRazorProvideDynamicFileInfo,
                    ["razor/languageQuery"] = function(error, result, context)
                        -- vim.notify("razor/languageQuery: " .. vim.inspect(result), vim.log.levels.INFO)
                        M.razor_map_to_document_ranges(result.kind, context)
                    end,
                    ["razor/provideHtmlDocumentColors"] = function(_, response, context)
                        -- vim.notify("razor/provideHtmlDocumentColors: " .. vim.inspect(response), vim.log.levels.INFO)
                    end,
                    ["razor/updateHtmlBuffer"] = function(_, response, context)
                        -- vim.notify("razor/updateHtmlBuffer: " .. vim.inspect(response), vim.log.levels.INFO)
                        M.razor_language_query("file://" .. response.hostDocumentFilePath)
                    end,
                    ["razor/updateCSharpBuffer"] = function(_, response, context)
                        -- vim.notify("razor/updateCSharpBuffer: " .. vim.inspect(response), vim.log.levels.INFO)
                        M.razor_language_query("file://" .. response.hostDocumentFilePath)
                    end,
                    ["razor/mapToDocumentRanges"] = function(_, response, context)
                        -- vim.notify("razor/mapToDocumentRanges: " .. vim.inspect(response), vim.log.levels.INFO)
                    end,
                }
            })
            if client_id ~= nil and bufnr then
                vim.lsp.buf_attach_client(bufnr, client_id)
            end
        end
    })
end

return M
