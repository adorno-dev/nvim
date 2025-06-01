return {
    cmd = { "pyright-langserver" },
    filetypes = { "python" },
    settings = {
        python = {
            analysis = {
                autoImportCompletions = true,
                autoImportModuleNames = true,
            },
        },
    },
}
