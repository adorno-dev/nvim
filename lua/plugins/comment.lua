return {
    "numtostr/comment.nvim",
    event = "InsertEnter",
    config = function()
        require("Comment").setup()
    end,
}
