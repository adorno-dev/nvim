return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- event = "VeryLazy",
        event = { "BufRead", "BufNewFile" },
        build = ":TSUpdate",
        config = function(_, opts)
            local config = require("nvim-treesitter.configs")
            local parsers = require("nvim-treesitter.parsers")
            config.setup({
                ensure_installed = { "lua" },
                modules = {},
                ignore_install = {},
                sync_install = true,
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })

        require("nvim-treesitter.install").prefer_git = true

        ---@diagostic disable-next-line
        parsers.get_parser_configs()
               .razor = {
                    install_info = {
                        url = "https://github.com/tris203/tree-sitter-razor",
                        files = { "src/parser.c", "src/scanner.c" },
                        branch = "main",
                    },
                    filetype = "razor",
        }
        config.setup(opts)

        end,
    },
}
