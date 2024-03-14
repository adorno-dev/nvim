return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		require('bufferline')
			.setup {
				options = {
					mode = 'buffers',
					offsets = {
						{
							filetype = 'NvimTree',
							text = 'File Explorer',
							highlight = 'Directory',
							separator = true,
							text_align = 'center'
						},
					}
				},
			}
		vim.keymap.set('n', '<M-h>', ':bprevious<cr>', {})
		vim.keymap.set('n', '<M-l>', ':bnext<cr>', {})
		vim.keymap.set('n', '<C-w>', ':bprevious|bdelete #<cr>', {})
	end
}
