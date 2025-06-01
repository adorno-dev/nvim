local lspconfig = require("lspconfig.configs")

lspconfig.roslyn = {
    default_config = {
        name = "roslyn",
        cmd = {
            "dotnet",
            "exec",
            "/home/developer/.vscode/extensions/ms-dotnettools.csharp-2.23.15-linux-x64/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
            "--telemetryLevel=off",
            "--logLevel=Information",
            "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        },
        autostart = true,
        filetypes = { "cs" },
        root_dir = require("lspconfig").util.root_pattern("*.sln", "*.csproj"),
    },
}

return lspconfig.roslyn
