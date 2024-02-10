return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree")
            .setup {
                view = {
                    width = 50
                }
            }
        vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<cr>', {})
    end,
}