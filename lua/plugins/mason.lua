return {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "nvimtools/none-ls.nvim",
        --
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            registries = {
                'github:mason-org/mason-registry',
                'github:crashdummyy/mason-registry',
            },
            handlers = {
                function(server_name)
                    local autocomplete = require("cmp_nvim_lsp")
                    require("lspconfig")[server_name].setup({
                        capabilities = autocomplete.default_capabilities(),
                        on_init = autocomplete.on_init,
                        on_attach = autocomplete.on_attach,
                    })
                end,
            }
        })
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls" },
        })
        -- require("mason-nvim-dap").setup({
        --     ensure_installed = { "stylua" },
        --     handlers = {},
        -- })
        require("mason-null-ls").setup({
            automatic_installation = true,
            ensure_installed = { "stylua" },
            handlers = {},
        })
    end,
}
