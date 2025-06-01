return {
    "mofiqul/vscode.nvim",
    event = "UIEnter",
    config = function()
        local colors = require("vscode.colors").get_colors()
        local vscode = require("vscode")
        -- vim.o.background = "dark"
        -- vim.o.background = "light"
        vscode.setup({
            color_overrides = { vscLineNumber = "#FFFFFF" },
            group_overrides = { Cursor = { fg = colors.vscDarkBlue, bg = colors.vscLightGreen, bold = true } },
            transparent = true,
            italic_comments = true,
            underline_links = true,
            disable_nvimtree_bg = true,
        })
        vscode.load()
        -- vim.cmd.colorscheme("vscode")
    end,
}
