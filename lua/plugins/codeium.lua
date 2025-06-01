return {
    {
        "exafunction/codeium.vim",
        event = "BufEnter",
        config = function()
            vim.g.codeium_disable_bindings = 1
            vim.keymap.set("i", "<C-g>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true, silent = true })
            vim.keymap.set("i", "<c-;>", function()
                return vim.fn["codeium#CycleCompletions"](1)
            end, { expr = true, silent = true })
            vim.keymap.set("i", "<c-,>", function()
                return vim.fn["codeium#CycleCompletions"](-1)
            end, { expr = true, silent = true })
            vim.keymap.set("i", "<c-x>", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true, silent = true })
        end,
    },
    {
        "exafunction/codeium.nvim",
        enabled = not vim.g.vscode,
        event = "InsertEnter",
        dependencies = {
            { "nvim-lua/plenary.nvim", event = "InsertEnter" },
            { "hrsh7th/nvim-cmp",      event = "InsertEnter" },
        },
        config = function()
            require("codeium").setup({})
            vim.cmd("highlight CodeiumSuggestion guifg=#555555 ctermfg=8")
        end,
    },
}
