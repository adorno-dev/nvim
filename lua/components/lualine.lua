return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local init = {}
		init.diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " " },
			colored = false,
			update_in_insert = false,
			always_visible = true,
		}
		init.diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = init.hide_in_width,
		}
		init.mode = {
			"mode",
			fmt = function(str)
				return "-- " .. str .. " --"
			end,
		}
		init.filetype = { "filetype", icons_enabled = false, icon = nil }
		init.branch = { "branch", icons_enabled = true, icon = "" }
		init.location = { "location", padding = 0 }

		init.hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end

		init.spaces = function()
			return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
		end

		init.progress = function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
				always_divide_middle = true,
			},
			sections = {
				-- lualine_a = { init.branch, init.diagnostics },
				lualine_a = { init.diagnostics, init.branch },
				lualine_b = { init.mode },
				lualine_c = {},
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_x = { init.diff, init.spaces, "encoding", init.filetype },
				lualine_y = { init.location },
				lualine_z = { init.progress },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
