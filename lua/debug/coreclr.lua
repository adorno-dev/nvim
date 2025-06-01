HOME = vim.fn.expand("$HOME")

return {
    adapters = {
        coreclr = {
            type = "executable",
            command = HOME .. "/.local/share/nvim/mason/packages/netcoredbg/netcoredbg",
            args = { "--interpreter=vscode" },
        }
    },
    configurations = {
        cs = {
            {
                type = "coreclr",
                name = "Launch - netcoredbg",
                request = "launch",
                externalConsole = true,
                program = function()
                    local csproj = "./" .. string.gsub(vim.fn.system("ls *.csproj"), "\n", "")
                    local debug = nil
                    os.execute("dotnet build " .. csproj .. " > /dev/null 2>&1")
                    debug = csproj:match(".*/([^/]+)%.%w+$") .. ".dll"
                    debug = vim.fn.system("find `pwd` -type f -name '" .. debug .. "' | grep -i bin/debug")
                    debug = string.gsub(debug, "\n", "")
                    return debug
                end,
            },
            {
                type = "coreclr",
                name = "Attach",
                request = "attach",
                processId = require "dap.utils".pick_process
            },
        }
    }
}
