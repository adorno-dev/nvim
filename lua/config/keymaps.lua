-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', {})
vim.keymap.set('n', '<C-l>', '<C-w>l', {})
vim.keymap.set('n', '<C-j>', '<C-w>j', {})
vim.keymap.set('n', '<C-k>', '<C-w>k', {})

-- common shortcuts
vim.keymap.set('n', 'q', ':quit<cr>', {})
vim.keymap.set('n', '<C-q>', ':quitall!<cr>', {})
vim.keymap.set('n', '<C-s>', ':write<cr>', {})
