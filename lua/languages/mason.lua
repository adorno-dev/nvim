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
        require ('mason')
            .setup ()
    end
}