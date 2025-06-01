return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>ff", ":Telescope find_files<CR>",              desc = "Find files" },
        { "<leader>fg", ":Telescope live_grep<CR>",               desc = "Live grep" },
        { "<leader>fb", ":Telescope buffers<CR>",                 desc = "Find buffers" },
        { "<leader>fh", ":Telescope help_tags<CR>",               desc = "Find help" },
        { "<leader>fi", ":Telescope media_files<CR>",             desc = "Find Images" },
        { "<C-j",       ":Telescope move_selection_next<CR>",     desc = "Next selection" },
        { "<C-k",       ":Telescope move_selection_previous<CR>", desc = "Previous selection" },
    },
    tag = "0.1.6",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        { "nvim-telescope/telescope-media-files.nvim", event = "VeryLazy" },
        { "nvim-telescope/telescope-ui-select.nvim",   event = "VeryLazy" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup({
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
                file_ignore_patterns = { '%__virtual.cs$' },
            },
            extensions = {
                ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
                media_files = {
                    filetypes = { "png", "webp", "jpg", "jpeg" },
                    find_cmd = "fd",
                },
            },
        })
        telescope.load_extension("ui-select")
        telescope.load_extension("media_files")
        telescope.load_extension("rest")
    end,
}
