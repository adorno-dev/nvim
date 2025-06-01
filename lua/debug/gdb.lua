return {
    adapters = {
        gdb = {
            type = "executable",
            command = "gdb",
            args = { "-i", "dap" },
        },
    },
    configurations = {
        c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = 'Attach to process (GDB)',
                type = 'gdb',
                request = 'attach',
                processId = require('dap.utils').pick_process,
            }
        }
    },
}
