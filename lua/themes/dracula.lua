return {
    "maxmx03/dracula.nvim",
    config = function()
        local dracula = require 'dracula'
        dracula.setup {
            soft = false,
            transparent = true
        }
        vim.cmd ("colorscheme dracula")
    end,
}