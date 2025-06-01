local lspconfig = require("lspconfig.configs")

lspconfig.aspnetcorerazor = {
    default_config = {
        name = "aspnetcorerazor",
        cmd = {
            "rzls",
            "--logLevel=Information",
            "--projectConfigurationFileName=project.razor.vscode.bin",
            "--DelegateToCSharpOnDiagnosticPublish=true",
            "--UpdateBuffersForClosedDocuments=true",
        },
        autostart = true,
        filetypes = { "razor", "cshtml", "html.cshtml.razor" },
        root_dir = require("lspconfig").util.root_pattern("*.sln", "*.csproj"),
        on_init = function(client)
            client.notify("razor/initialize")
        end
    }
}

return lspconfig.aspnetcorerazor
