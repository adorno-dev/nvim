---@class InternalRoslynNvimConfig
---@field filewatching "auto" | "off" | "roslyn"
---@field choose_target? fun(targets: string[]): string?
---@field ignore_target? fun(target: string): boolean
---@field broad_search boolean
---@field lock_target boolean

---@class RoslynNvimConfig
---@field filewatching? boolean | "auto" | "off" | "roslyn"
---@field choose_target? fun(targets: string[]): string?
---@field ignore_target? fun(target: string): boolean
---@field broad_search? boolean
---@field lock_target? boolean

---@type InternalRoslynNvimConfig
local roslyn_config = {
    filewatching = "off",
    choose_target = nil,
    ignore_target = nil,
    broad_search = false,
    lock_target = false,
}

return {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    dependencies = {
        {
            "tris203/rzls.nvim",
            config = true,
        },
    },
    opts = {
        filewatching = "off",
        broad_search = true,
    },
    config = function()
        local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
        local cmd = {
            "roslyn",
            "--stdio",
            "--logLevel=Information",
            "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
            "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
            "--razorDesignTimePath=" .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
            "--extension",
            vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
        }
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        vim.lsp.config("roslyn", {
            cmd = cmd,
            handlers = require("rzls.roslyn_handlers"),
            capabilities = capabilities,
            settings = {
                ["csharp|inlay_hints"] = {
                    csharp_enable_inlay_hints_for_implicit_object_creation = true,
                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                    csharp_enable_inlay_hints_for_types = true,
                    dotnet_enable_inlay_hints_for_indexer_parameters = true,
                    dotnet_enable_inlay_hints_for_literal_parameters = true,
                    dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                    dotnet_enable_inlay_hints_for_other_parameters = true,
                    dotnet_enable_inlay_hints_for_parameters = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                },
                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = true,
                },
                ["csharp|completion"] = {
                    dotnet_show_completion_items_from_unimported_namespaces = true,
                },
                ["csharp|symbol_search"] = {
                    dotnet_search_reference_assemblies = true,
                },
                ["csharp|formatting"] = {
                    dotnet_organize_imports_on_format = true,
                },
            },
        })

        if roslyn_config.filewatching == "off" or roslyn_config.filewatching == "roslyn" then
            capabilities.workspace = capabilities.workspace or {}
            capabilities.workspace.didChangeWatchedFiles = capabilities.workspace.didChangeWatchedFiles or {}
            capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = roslyn_config.filewatching == "off"
        end

        vim.lsp.enable("roslyn")
    end,
    init = function()
        -- We add the Razor file types before the plugin loads.
        vim.filetype.add({
            extension = {
                razor = "razor",
                cshtml = "razor",
            },
        })
    end,
}
