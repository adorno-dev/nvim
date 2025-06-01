return {
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            completion = {
                imports = {
                    enabled = true, -- enable auto imports
                },
            },
            diagnostics = {
                globals = { "vim" }, -- Inclui os dados do Vim
            },
            runtime = {
                -- version = "LuaJIT",
                version = "Lua 5.4",
                path = vim.split(package.path, ";"),
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
}
