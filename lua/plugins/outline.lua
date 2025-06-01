return {
    "hedyhli/outline.nvim",
    keys = {
        { "<leader>o", "<cmd>:lua require('outline').toggle({focus_on_open=false})<CR>", desc = "Toggle Outline" },
    },
    config = function()
        -- vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
        --     { desc = "Toggle Outline" })
        --
        require("outline").setup {
            outline_window = {
                width = 50,
                relative_width = false,
            }
        }
    end,
}
