local keymap = vim.keymap.set

local mappings = {}

-- window navigation
keymap("n", "<C-h>", "<C-w>h", {})
keymap("n", "<C-l>", "<C-w>l", {})
keymap("n", "<C-j>", "<C-w>j", {})
keymap("n", "<C-k>", "<C-w>k", {})

-- common shortcuts
keymap("n", "q", ":quit<cr>", {})
keymap("n", "<C-q>", ":quitall!<cr>", {})
keymap("n", "<C-s>", ":write<cr>", {})

-- split shortcuts
keymap('n', 'ss', '<cmd>split<cr>')
keymap('n', 'sv', '<cmd>vsplit<cr>')

return mappings
