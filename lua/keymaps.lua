-- navigate win panes better
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {})
vim.keymap.set("n", "<C-l>", "<C-w>l", {})
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
vim.keymap.set("n", "<C-k>", "<C-w>k", {})

-- tab navigation
vim.keymap.set("n", "<M-l>", ":tabnext<cr>", { silent = true })
vim.keymap.set("n", "<M-h>", ":tabprevious<cr>", { silent = true })

-- common shortcuts
vim.keymap.set("n", "q", ":quit<cr>", { silent = true })
vim.keymap.set("n", "<C-q>", ":quitall!<cr>", { silent = true })
vim.keymap.set("n", "<C-s>", ":write<cr>", { silent = true })

-- split shortcuts
vim.keymap.set("n", "<leader>ss", "<cmd>split<cr>", { silent = true })
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", { silent = true })

-- leadermap key
vim.g.mapleader = " "
