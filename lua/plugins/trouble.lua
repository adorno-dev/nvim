return {
    "folke/trouble.nvim",
    -- event = { "BufEnter", "BufNewFile", "VeryLazy" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, desc = "Toggle trouble" } },
        { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, desc = "Workspace diagnostics"} },
        { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, desc = "Document diagnostics"} },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, desc = "Quickfix"} },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, desc = "Location list"} },
        { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, desc = "LSP references"} },
        { "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, desc = "LSP references"} },
    },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        -- require("trouble").setup {}
        require('trouble').setup {
              modes = {
                diagnostics = {
                  filter = function(items)
                    return vim.tbl_filter(function(item)
                      return not string.match(item.basename, [[%__virtual.cs$]])
                    end, items)
                  end,
                },
              },
        }
    end
}
