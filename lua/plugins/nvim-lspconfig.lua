-- kind_icons
local diagnostic_icons = {
    Error = " ",
    Warn  = " ",
    Hint  = " ",
    Info  = " ",
}

-- 👇 define os signs corretamente
for type, icon in pairs(diagnostic_icons) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Configuração do LSP
vim.diagnostic.config({
    signs = {
        active = true, -- ou pode remover isso, já que os signs foram definidos acima
    },
    virtual_text = { prefix = "●" },
})

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        servers = {
            html = {
                filetypes = { "html", "razor", "cshtml" }, -- "templ"
            }
        }
    },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "folke/neodev.nvim", event = "InsertEnter" },
        -- TODO: load one of these two options to improve performance
        -- { "decodetalkers/csharpls-extended-lsp.nvim", event = "InsertEnter" },
        -- { "hoffs/omnisharp-extended-lsp.nvim",        event = "InsertEnter" },
    },
    keys = {
        { "<leader>K",  ":lua vim.lsp.buf.hover()<CR>",                                      silent = true, desc = "Hover" },
        { "<leader>gD", ":lua vim.lsp.buf.declaration()<CR>",                                silent = true, desc = "Go to declaration" },
        { "<leader>gd", ":lua vim.lsp.buf.definition()<CR>",                                 silent = true, desc = "Go to definition" },
        { "<leader>gr", ":lua vim.lsp.buf.references()<CR>",                                 silent = true, desc = "Go to references" },
        { "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>",                                silent = true, desc = "Code action" },
        { "<leader>rn", ":lua vim.lsp.buf.rename()<CR>",                                     silent = true, desc = "Rename" },
        { "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>",                             silent = true, desc = "Go to implementation" },
        { "<leader>gs", ":lua vim.lsp.buf.signature_help()<CR>",                             silent = true, desc = "Signature help" },
        { "<leader>wa", ":lua vim.lsp.buf.add_workspace_folder()<CR>",                       silent = true, desc = "Add workspace folder" },
        { "<leader>wr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>",                    silent = true, desc = "Remove workspace folder" },
        { "<leader>wl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", silent = true, desc = "List workspace folders" },
    },
    -- manual lsp configuration
    config = function()
        require("neodev").setup({ library = { plugins = { "nvim-dap-ui", "nvim-treesitter" } } })
    end
}
