return {
    "rest-nvim/rest.nvim",
    event = "UIEnter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, "http")
            vim.keymap.set("n", "<leader>rs", ":lua require('rest-nvim').run()<CR>", { silent = true, noremap = true })
        end,
    }
}
