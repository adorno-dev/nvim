return {
    'williamboman/mason.nvim',
    dependencies = {
        {
            'williamboman/mason-lspconfig.nvim',
            lazy = false,
            opts = { auto_install = true }
        }
    },
    config = function()

        require ('mason').setup ()

        local mappings = require ('config.keymaps')

        mappings.m = {
            name = 'Mason Package Manager',
            m = { '<cmd>Mason<cr>', 'Mason Screen' },
            l = { '<cmd>MasonLog<cr>', 'Mason Logs' },
            u = { '<cmd>MasonUpdate<cr>', 'Mason Update' },
        }

    end
}
