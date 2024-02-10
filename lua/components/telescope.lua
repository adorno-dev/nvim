return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require ('telescope')
                .setup {}
            vim.keymap.set('n', 'ff', ':Telescope find_files<cr>', {})
            vim.keymap.set('n', 'fg', ':Telescope live_grep<cr>', {})
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
