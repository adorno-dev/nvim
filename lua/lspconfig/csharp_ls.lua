return {
    cmd = { "csharp-ls" },
    filetypes = { "cs" },
    init_options = {
        AutomaticWorkspaceInit = false,
    },
    preview = true,
    handlers = {
        ["textDocument/definition"] = require("csharpls_extended").handler,
        ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
    },
}
