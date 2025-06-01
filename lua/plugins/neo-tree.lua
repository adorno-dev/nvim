return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree toggle",
    keys = {
        { "<C-n>", ":Neotree toggle<CR>", desc = "Toggle NeoTree", silent = true },
    },
    branch = "v3.x",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-lua/plenary.nvim",
            event = "VeryLazy",
            cmd = "Neotree toggle",
            keys = { "<C-n>", ":Neotree toggle<CR>" },
        },
        {
            "MunifTanjim/nui.nvim",
            event = "VeryLazy",
            cmd = "Neotree toggle",
            keys = { "<C-n>", ":Neotree toggle<CR>" },
        },
    },
    config = function()
        vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { silent = true })
        require("neo-tree").setup({
            close_if_last_window = false,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            default_component_configs = {
                container = {
                    enable_character_fade = true,
                },
                git_status = {
                    symbols = {
                        added     = "",
                        modified  = "",
                        deleted   = "",
                        renamed   = "󰁕",
                        untracked = "",
                        ignored   = "",
                        unstaged  = "󰄱",
                        staged    = "",
                        conflict  = "",
                    },
                },
                diagnostics = {
                    symbols = {
                        hint = "💡",
                        info = "",
                        warning = "",
                        error = "",
                    },
                    highlights = {
                        hint = "DiagnosticHint",
                        info = "DiagnosticInfo",
                        warning = "DiagnosticWarn",
                        error = "DiagnosticError",
                    },
                },
                modified = {
                    symbol = "",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                },
            },
            source_selector = {
                winbar = true,
                statusline = false,
            },
            window = {
                position = "left",
                width = 50,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                title = "",
            },
            filesystem = {
                filtered_items = {
                    use_libuv_file_watcher = true,
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    never_show = {
                        ".vs",
                        ".vscode",
                        ".idea",
                        "bin",
                        "obj",
                    },
                },
            },
        })

    end,
}
