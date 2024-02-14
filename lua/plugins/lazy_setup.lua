local lazy = require ('lazy')

local plugins = {
    require ('themes.catppuccin'),
    
    require ('components.nvim-tree'),
    require ('components.bufferline'),
    require ('components.lualine'),
    require ('components.telescope'),
    require ('components.terminal'),

    require ('languages.mason'),
    require ('languages.lsp-snippets'),
    require ('languages.lsp-completion'),
    require ('languages.lsp-support'),
    require ('languages.highlighting'),
    require ('languages.formatting'),
    require ('languages.debugging'),

    require ('behaviors.comment'),
    require ('behaviors.autopairs'),
    require ('behaviors.autotags'),
}

lazy.setup(plugins)
