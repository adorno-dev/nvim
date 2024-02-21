return {
	'folke/which-key.nvim',
	config = function ()

		local which_key = require 'which-key'
		local mappings = require 'config.keymaps'

		which_key.register(mappings)

		which_key.setup({})

	end
}
