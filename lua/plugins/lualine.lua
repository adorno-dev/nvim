return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Eviline config for lualine
        -- Author: shadmansaleh
        -- Credit: glepnir
        local lualine = require("lualine")

        -- Color table for highlights
        -- stylua: ignore
        local colors = {
            bg       = '#202328',
            fg       = '#bbc2cf',
            yellow   = '#ECBE7B',
            cyan     = '#008080',
            darkblue = '#081633',
            green    = '#98be65',
            orange   = '#FF8800',
            violet   = '#a9a1e1',
            magenta  = '#c678dd',
            blue     = '#51afef',
            red      = '#ec5f67',
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand("%:p:h")
                local gitdir = vim.fn.finddir(".git", filepath .. ";")
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        -- Config
        local config = {
            -- extensions = { "neo-tree" },
            options = {
                ignore_focus = { "neo-tree", "Outline", "Telescope", "fugitiveblame", "Mason", "Lazy" },
                -- disabled_filetypes = { "neo-tree" },
                globalstatus = true,
                -- Disable sections and component separators
                component_separators = "",
                section_separators = "",
                theme = "auto",
                -- theme = {
                --     -- We are going to use lualine_c an lualine_x as left and
                --     -- right section. Both are highlighted by c theme .  So we
                --     -- are just setting default looks o statusline
                --     normal = { c = { fg = colors.fg, bg = colors.bg } },
                --     inactive = { c = { fg = colors.fg, bg = colors.bg } },
                -- },
            },
            sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                -- These will be filled later
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x at right section
        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left({
            function()
                return "▊"
            end,
            color = { fg = colors.blue },      -- Sets highlighting of component
            padding = { left = 0, right = 1 }, -- We don't need space before this
        })

        ins_left({
            -- mode component
            function()
                -- return ""
                return ""
            end,
            color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                    n = colors.red,
                    i = colors.green,
                    v = colors.blue,
                    ["^V"] = colors.blue,
                    V = colors.blue,
                    c = colors.magenta,
                    no = colors.red,
                    s = colors.orange,
                    S = colors.orange,
                    ["^S"] = colors.orange,
                    ic = colors.yellow,
                    R = colors.violet,
                    Rv = colors.violet,
                    cv = colors.red,
                    ce = colors.red,
                    r = colors.cyan,
                    rm = colors.cyan,
                    ["r?"] = colors.cyan,
                    ["!"] = colors.red,
                    t = colors.red,
                }
                return { fg = mode_color[vim.fn.mode()] }
            end,
            padding = { right = 1 },
        })

        ins_left({
            "branch",
            icon = "",
            color = { fg = colors.violet, gui = "bold" },
        })

        ins_left({
            "diff",
            -- Is it me or the symbol for modified us really weird
            symbols = { added = " ", modified = "󰝤 ", removed = " " },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
        })

        ins_left({
            "filename",
            cond = conditions.buffer_not_empty,
            color = { fg = colors.magenta, gui = "bold" },
        })

        ins_left({
            -- filesize component
            "filesize",
            cond = conditions.buffer_not_empty,
        })

        ins_left({
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
            diagnostics_color = {
                color_error = { fg = colors.red },
                color_warn = { fg = colors.yellow },
                color_info = { fg = colors.cyan },
            },
        })

        -- Insert mid section. You can make any number of sections in neovim :)
        -- for lualine it's any number greater then 2
        ins_left({
            function()
                return "%="
            end,
        })

        ins_right({
            function()
                local treesitter = require("nvim-treesitter.statusline").statusline(90)
                if string.gsub(treesitter, "%s+", "") ~= "" then
                    return " TS"
                else
                    return ""
                end
            end,
            color = { fg = colors.green, gui = "bold" },
        })

        -- Add components to right sections
        ins_right({
            "o:encoding",       -- option component same as &encoding in viml
            fmt = string.upper, -- I'm not sure why it's upper case either ;)
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = "bold" },
        })

        ins_right({
            "fileformat",
            fmt = string.upper,
            icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
            color = { fg = colors.green, gui = "bold" },
        })

        ins_right({
            function()
                local names = {}
                local bufnr = vim.api.nvim_get_current_buf()
                local buf_ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
                local exclude = { ["null-ls"] = true, ["copilot"] = true }

                for _, client in ipairs(vim.lsp.get_clients()) do
                    local is_attached = client.attached_buffers and client.attached_buffers[bufnr]
                    local matches_filetype = client.config.filetypes and
                    vim.fn.index(client.config.filetypes, buf_ft) ~= -1

                    if (is_attached or matches_filetype) and not exclude[client.name] then
                        local name = client.name
                        if #name > 20 then
                            name = name:sub(1, 17) .. "..."
                        end
                        table.insert(names, name)
                    end
                end

                local icon = "  "

                if #names == 0 then
                    vim.api.nvim_set_hl(0, "LspStatusInactive", { fg = "#777777", bold = false })
                    return "%#LspStatusInactive#" .. icon .. "No LSP"
                else
                    vim.api.nvim_set_hl(0, "LspStatusActive", { fg = colors.orange, bold = true })
                    local label = table.concat(names, ", ")
                    if #names > 1 then
                        label = label .. " (" .. #names .. ")"
                    end
                    return "%#LspStatusActive#" .. icon .. label
                end
            end,
            icon = "", -- removido, já que usamos manualmente no texto
            color = nil, -- para permitir highlights dinâmicos
        })

        ins_right({
            function()
                local codeium = vim.api.nvim_call_function("codeium#GetStatusString", {})
                if string.gsub(codeium, "%s+", "") ~= "" then
                    -- return ""
                    return ""
                else
                    return ""
                end
            end,
            color = { fg = colors.violet, gui = "bold" },
        })

        ins_right({ "location" })

        ins_right({ "progress", color = { fg = colors.fg, gui = "bold" } })


        ins_right({
            function()
                return "▊"
            end,
            color = { fg = colors.blue },
            padding = { left = 1 },
        })

        -- Now don't forget to initialize lualine
        lualine.setup(config)
    end,
}
