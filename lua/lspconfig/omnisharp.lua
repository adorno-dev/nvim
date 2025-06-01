local omnisharp_extended = require("omnisharp_extended")
return {
    cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },
    filetypes = { "cs" },
    preview = true,
    omnisharp = {
        useModernNet = true,
        monoPath = "/usr/bin/mono",
    },
    type_definition = true,
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = false,
    enable_import_completion = true,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = false,
    sdk_include_prereleases = true,
    analyze_open_documents_only = true,
    handlers = {
        ["textDocument/definition"] = omnisharp_extended.definition_handler,
        ["textDocument/typeDefinition"] = omnisharp_extended.type_definition_handler,
        ["textDocument/references"] = omnisharp_extended.references_handler,
        ["textDocument/implementation"] = omnisharp_extended.implementation_handler,
    },
    settings = {
        FormattingOptions = {
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            EnableEditorConfigSupport = true,
            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            OrganizeImports = true,
        },
        MsBuild = {
            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            LoadProjectsOnDemand = false,
        },
        RoslynExtensionsOptions = {
            -- Enables support for roslyn analyzers, code fixes and rulesets.
            EnableAnalyzersSupport = true,
            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            EnableImportCompletion = true,
            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            AnalyzeOpenDocumentsOnly = false,
        },
        Sdk = {
            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            IncludePrereleases = true,
        },
    },
}
