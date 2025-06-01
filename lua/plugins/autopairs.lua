return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    lazy = true,
    config = function()
        require("nvim-autopairs").setup({})
    end,
}
