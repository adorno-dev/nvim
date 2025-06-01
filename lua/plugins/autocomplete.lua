local kind_icons = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
    Codeium = "",
}

return {
    {
        "l3mon4d3/luasnip",
        event = "InsertEnter",
        version = "v2p*",
        run = "make install_jsregexp",
        dependencies = {
            { "saadparwaiz1/cmp_luasnip",     event = "InsertEnter" },
            { "rafamadriz/friendly-snippets", event = "InsertEnter" },
            -- { "hrsh7th/vim-vsnip",            event = "InsertEnter" },
            -- { "dcampos/nvim-snippy",          event = "InsertEnter" },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "VeryLazy", "CmdlineEnter", "CmdlineChanged" },
        dependencies = {
            { "hrsh7th/cmp-path",                    event = "InsertEnter" },
            { "hrsh7th/cmp-buffer",                  event = "InsertEnter" },
            { "hrsh7th/cmp-cmdline",                 event = "InsertEnter" },
            { "hrsh7th/cmp-nvim-lua",                event = "InsertEnter" },
            { "hrsh7th/cmp-nvim-lsp",                event = "InsertEnter" },
            { "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
            -- { "hrsh7th/cmp-vsnip",                   event = "InsertEnter" },
            -- { "dcampos/cmp-snippy",                  event = "InsertEnter" },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            -- Use of autocompletion
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                        -- vim.snippet.expand(args.body)
                        -- vim.fn["vsnip#anonymous"](args.body)
                        -- require("snippy").expand_snippet(args.body)
                        -- require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    -- ["<Tab>"] = cmp.mapping.select_next_item(),
                    -- ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp_signature_help" },
                    { name = "neodev" },
                    { name = "nvim_lua" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    -- { name = "snippy" },
                    -- { name = "vsnip" },
                    { name = "friendly-snippets" },
                    { name = "codeium" },
                    -- { name = "cmdline" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = function(_, vim_item)
                        vim_item.menu = "\t" .. vim_item.kind
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                        return vim_item
                    end,
                },
            })
            -- Set configuration for specific filetype.
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources(
                -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                    { { name = "git" } },
                    { { name = "buffer" } }
                ),
            })
            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
            })
            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })
        end,
    },
}
