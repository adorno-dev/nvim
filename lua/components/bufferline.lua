return {
    'akinsho/bufferline.nvim', 
    version = "*", 
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require ('bufferline')
            .setup {}
        vim.keymap.set('n', '<M-h>', ':bprevious<cr>', {})
        vim.keymap.set('n', '<M-l>', ':bnext<cr>', {})
        vim.keymap.set('n', '<C-w>', ':bprevious|bdelete #<cr>', {})
    end
}