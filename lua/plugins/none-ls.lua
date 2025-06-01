return {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    keys = { { "<leader>gf", ":lua vim.lsp.buf.format()<cr>", silent = true } },
}
