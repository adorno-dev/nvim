return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'jlcrochet/vim-razor'
    },
    build = ':TSUpdate',
    config = function()
        require ('nvim-treesitter.configs')
            .setup {
                auto_install = true,
                sync_install = false,
                ignore_install = {},
                ensure_installed = { 'lua', 'javascript', 'c_sharp' },
                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true
                }
            }
    end
}