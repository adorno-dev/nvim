return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {},
    config = function()
        local highlight = {
            "CursorColumn",
            "Whitespace",
        }
        require("ibl").setup {
            indent = { highlight = highlight, char = "" },
            whitespace = {
                highlight = highlight,
                remove_blankline_trail = false,
            },
            scope = { enabled = false },
        }
    end
}
