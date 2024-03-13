return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local completion = require("cmp_nvim_lsp")
			local lsp_config = require("lspconfig")
			local servers = {
				-- 'csharp_ls',
				"omnisharp",
				"docker_compose_language_service",
				"dockerls",
				"kotlin_language_server",
				"clangd",
				"rust_analyzer",
				"lua_ls",
				"emmet_ls",
				"html",
				"cssls",
				"tailwindcss",
				"pyright",
				"tsserver",
			}
			for _, server in ipairs(servers) do
				lsp_config[server].setup({ capabilities = completion.default_capabilities() })
			end
			-- omnisharp
			lsp_config.omnisharp.setup({
				capabilities = capabilities,
				-- cmd = { "dotnet", os.getenv("HOME") .."/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
				cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },
				filetypes = { "cs" },
				omnisharp = {
					useModernNet = true,
					monoPath = "/usr/bin/mono",
				},
				type_definition = true,
				enable_editorconfig_support = true,
				enable_ms_build_load_projects_on_demand = false,
				enable_import_completion = false,
				enable_roslyn_analyzers = true,
				organize_imports_on_format = false,
				sdk_include_prereleases = true,
				analyze_open_documents_only = true,
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "rn", vim.lsp.buf.rename, {})

			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, {})
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, {})
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, {})

			-- -- Use LspAttach autocommand to only map the following keys
			-- -- after the language server attaches to the current buffer
			-- vim.api.nvim_create_autocmd('LspAttach', {
			--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			--     callback = function(ev)
			--     -- Enable completion triggered by <c-x><c-o>
			--     vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

			--     -- Buffer local mappings.
			--     -- See `:help vim.lsp.*` for documentation on any of the below functions
			--     local opts = { buffer = ev.buf }
			--     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
			--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
			--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
			--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
			--     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
			--     vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
			--     vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
			--     vim.keymap.set('n', '<space>wl', function()
			--         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			--     end, opts)
			--     vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
			--     vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
			--     vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
			--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
			--     vim.keymap.set('n', '<space>f', function()
			--         vim.lsp.buf.format { async = true }
			--     end, opts)
			--     end,
			-- })
		end,
	},
	-- {
	--     'ray-x/lsp_signature.nvim',
	--     event = 'VeryLazy',
	--     opts = {},
	--     config = function(_, opts)
	--         require ('lsp_signature')
	--             .setup(opts)
	--     end
	-- },
}
