return {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
        local autotags = require("nvim-ts-autotag")
        local filetypes = {
            'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
            'rescript', 'xml', 'php', 'markdown', 'astro', 'glimmer', 'handlebars', 'hbs', 'razor', 'cshtml',
        }
        local skip_tags = {
            'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
            'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr', 'menuitem'
        }
        autotags.setup({
            filetypes,
            skip_tags
        })
    end,
}
