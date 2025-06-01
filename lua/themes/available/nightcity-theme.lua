return {
	"cryptomilk/nightcity.nvim",
	event = "UIEnter",
	version = "*",
	config = function()
		vim.cmd.colorscheme("nightcity")
	end,
}
