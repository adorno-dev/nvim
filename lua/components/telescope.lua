return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()

            -- local mappings = require ('config.keymaps')

            require ('telescope')
                .setup {}
            
            -- mappings.f = {
            --   name = 'Telescope Search',
            --   f = { '<cmd>Telescope find_files<cr>', 'Telescope Files' },
            --   g = { '<cmd>Telescope live_grep<cr>', 'Telescope Words' },
            -- }
          
            vim.keymap.set('n', 'ff', ':Telescope find_files<cr>', {})
            vim.keymap.set('n', 'fg', ':Telescope live_grep<cr>', {})
            vim.keymap.set('n', 'fk', ':Telescope keymaps<cr>', {})
            vim.keymap.set('n', 'fh', ':Telescope help_tags<cr>', {})
            vim.keymap.set('n', 'fc', ':Telescope commands<cr>', {})

        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
          require('telescope').setup ({
            extensions = {
              ['ui-select'] = {
                require('telescope.themes').get_dropdown {
                }
              }
            }
          })
          require('telescope').load_extension('ui-select')
        end
      },
}
