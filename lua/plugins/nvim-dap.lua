HOME = vim.fn.expand("$HOME")

-- kind_icons
vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "",
    linehl = "",
    numhl = "",
})
vim.api.nvim_set_keymap("n", "<F6>", [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })

local bind_custom_daps = function(dap)
    local cmd = "/usr/bin/ls " .. HOME .. "/.config/nvim/lua/debug" .. " | " .. "sed 's/\\.lua//g'"
    local custom_dap = nil
    for _, name in ipairs(vim.fn.systemlist(cmd)) do
        custom_dap = require("debug." .. name)
        dap.adapters = vim.tbl_deep_extend("force", dap.adapters, custom_dap.adapters)
        dap.configurations = vim.tbl_deep_extend("force", dap.configurations, custom_dap.configurations)
    end
end

return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    keys = {
        { "<F9>",        ":DapToggleBreakpoint<CR>",  silent = true, desc = "Toggle breakpoint" },
        { "<F5>",        ":DapContinue<CR>",          silent = true, desc = "Continue" },
        { "<F10>",       ":DapStepOver<CR>",          silent = true, desc = "Step over" },
        { "<F11>",       ":DapStepInto<CR>",          silent = true, desc = "Step into" },
        { "<F12>",       ":DapStepOut<CR>",           silent = true, desc = "Step out" },
        { "<leader>dt",  ":DapTerminate<CR>",         silent = true, desc = "Terminate" },
        { "<leader>daw", ":lua require('dap.ui.widgets').hover()<CR>", silent = true, desc = "Toggle virtual text" },
    },
    config = function()
        bind_custom_daps(require("dap"))
    end
}
