return {
    "lewis6991/gitsigns.nvim",
    keys = {
        { "<leader>gp", ":Gitsigns preview_hunk<CR>",              silent = true },
        { "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", silent = true },
        { "<leader>gb", ":Git blame<CR>",                          silent = true },
    },
    dependencies = {
        "tpope/vim-fugitive",
    },
    config = function()
        require("gitsigns").setup()
    end,
}
