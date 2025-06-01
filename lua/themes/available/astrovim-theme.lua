return {
	"astronvim/astrotheme",
	event = "UIEnter",
	config = function()
		require("astrotheme").setup()
		vim.cmd.colorscheme("astrodark")
	end,
}
