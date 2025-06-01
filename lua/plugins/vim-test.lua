return {
    "vim-test/vim-test",
    keys = {
        { "<leader>t", ":TestNearest<CR>" },
        { "<leader>T", ":TestFile<CR>" },
        { "<leader>a", ":TestSuite<CR>" },
        { "<leader>l", ":TestLast<CR>" },
        { "<leader>g", ":TestVisit<CR>" },
    },
    dependencies = {
        { "preservim/vimux", event = "InsertEnter" },
    },
    config = function()
        vim.cmd("let test#strategy = 'vimux'")
    end,
}
