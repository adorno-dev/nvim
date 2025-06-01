return {
    "catppuccin/nvim",
    event = "UIEnter",
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("catppuccin")
    end,
}
