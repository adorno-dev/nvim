return {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    version = '^1.0.0',
    dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    config = function()
        vim.g.barbar_auto_setup = false
        require("barbar").setup({
            sidebar_filetypes = {
                ['neo-tree'] = {event = 'BufWipeout'},
                Outline = {event = 'BufWinLeave', text = 'symbols-outline', align = 'right'},
            },
            no_name_title = "[No Name]",
            vim.api.nvim_set_keymap("n", "<M-h>", ":BufferPrevious<CR>", { noremap = true, silent = true }),
            vim.api.nvim_set_keymap("n", "<M-l>", ":BufferNext<CR>", { noremap = true, silent = true }),
            vim.api.nvim_set_keymap("n", "<M-H>", ":BufferMovePrevious<CR>", { noremap = true, silent = true }),
            vim.api.nvim_set_keymap("n", "<M-L>", ":BufferMoveNext<CR>", { noremap = true, silent = true }),
            vim.api.nvim_set_keymap("n", "<C-w>", ":BufferClose!<CR>", { noremap = true, silent = true }),
        })
    end
}
