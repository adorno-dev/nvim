return {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer', -- Optional
    'hrsh7th/cmp-path', -- Optional
    'saadparwaiz1/cmp_luasnip', -- Optional
    'hrsh7th/cmp-nvim-lua', -- Optional
    'hrsh7th/cmp-nvim-lsp', -- Required
    {
        'hrsh7th/nvim-cmp', -- Required
        config = function()
            local cmp = require('cmp')
            local luasnip = require ('luasnip')
            local kind_icons = {
                Text = '',
                Method = 'm',
                Function = ' ',
                Constructor = '',
                Field = '',
                Variable = '',
                Class = '',
                Interface = '',
                Module = '',
                Property = '',
                Unit = '',
                Value = '',
                Enum = '',
                Keyword = ' ',
                Snippet = '',
                Color = '',
                File = '',
                Reference = '',
                Folder = '',
                EnumMember = '',
                Constant = '',
                Struct = '',
                Event = '',
                Operator = '',
                TypeParameter = ''
            }

            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup {
                snippet = {
                    expand = function(args)
						-- local luasnip = require ('luasnip')
                        luasnip.lsp_expand(args.body)
                        vim.cmd [[
                            " press <Tab> to expand or jump in a snippet. These can also be mapped separately
                            " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
                            imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
                            " -1 for jumping backwards.
                            inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
                
                            snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
                            snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
                
                            " For changing choices in choiceNodes (not strictly necessary for a basic setup).
                            imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
                            smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
                        ]]
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                mapping = cmp.mapping.preset.insert {

                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    -- ["<C-e>"] = cmp.mapping.abort(),

                    ['<C-Space>'] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ 
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true 
                    }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                          cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                          luasnip.expand_or_jump()
                        else
                          fallback()
                        end
                      end, { 'i', 's' }),
                      ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                          cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                          luasnip.jump(-1)
                        else
                          fallback()
                        end
                      end, { 'i', 's' }),
                },
                sources = cmp.config.sources {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'buffer' },
                },
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(entry, vim_item)
                    vim_item.kind = string.format('%s ', kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = '[LSP]',
                        luasnip = '[Snippet]',
                    })[entry.source.name]
                    return vim_item
                    end,
                },
            }

        end
    },
}
