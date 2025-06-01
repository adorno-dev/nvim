HOME = vim.fn.expand("$HOME")

-- IMPORTANT!!!
-- git clone https://github.com/tomblind/local-lua-debugger-vscode
-- cd local-lua-debugger-vscode
-- npm install
-- npm run build

return {
    adapters = {
        ["local-lua"] = {
            type = "executable",
            command = "node",
            args = {
                HOME .. "/.local/share/local-lua-debugger-vscode/extension/debugAdapter.js",
            },
            enrich_config = function(config, on_config)
                if not config["extensionPath"] then
                    local c = vim.deepcopy(config)
                    c.extensionPath = HOME .. "/.local/share/local-lua-debugger-vscode/"
                    on_config(c)
                else
                    on_config(config)
                end
            end,
        },
        nlua = function(callback, config)
            callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
        end,
    },
    configurations = {
        lua = {
            {
                name = "Current file (local-lua-dbg, lua)",
                type = "local-lua",
                request = "launch",
                cwd = "${workspaceFolder}",
                program = {
                    lua = "lua5.4",
                    -- lua = HOME .. "/.config/nvim/lua/" .. "nlua.lua",
                    file = "${file}",
                },
                verbose = true,
                args = {},
            },
            {
                name = "Attach to running Neovim instance",
                type = "nlua",
                request = "attach",
            },
        },
    },
}
