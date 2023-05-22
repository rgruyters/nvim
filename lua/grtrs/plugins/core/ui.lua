return {
    -- Plugin: Make bufferlines pretty
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = "nvim-web-devicons",
        opts = {
            options = {
                separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
                show_buffer_close_icons = false,
                show_close_icon = false,
                diagnostics = false,
            }
        },
    },
    -- Plugin: Blazing fast statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = "nvim-web-devicons",
        opts = function()
            M = {}
            local icons = require "grtrs.icons"

            local hide_in_width = function()
                return vim.o.columns > 80
            end

            local hide_in_width_100 = function()
                return vim.o.columns > 100
            end

            -- check if value in table
            local function contains(t, value)
                for _, v in pairs(t) do
                    if v == value then
                        return true
                    end
                end
                return false
            end

            -- List of filetypes to disable part of the statusline
            local ui_disable_filetypes = {
                "help",
                "lir",
                "mason",
                "",
            }

            -- return false if should be disabled
            local disable_filetype = function()
                return not contains(ui_disable_filetypes, vim.bo.filetype)
            end

            local scrollbar = {
                function()
                    local current_line = vim.fn.line "."
                    local total_lines = vim.fn.line "$"
                    local chars = { "  ", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
                    local line_ratio = current_line / total_lines
                    local index = math.ceil(line_ratio * #chars)
                    return chars[index]
                end,
                padding = { left = 0, right = 0 },
                cond = nil,
            }

            local spaces = {
                function()
                    return icons.misc.Spaces .. " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
                end,
                padding = 1,
                separator = "",
                cond = hide_in_width_100,
            }

            local lsp = {
                function(msg)
                    msg = msg or "LS Inactive"
                    local buf_clients = vim.lsp.buf_get_clients()
                    if next(buf_clients) == nil then
                        if type(msg) == "boolean" or #msg == 0 then
                            return "LS Inactive"
                        end
                        return msg
                    end

                    local buf_ft = vim.bo.filetype
                    local buf_client_names = {}
                    local copilot_active = false

                    -- add client
                    for _, client in pairs(buf_clients) do
                        if client.name ~= "copilot" and client.name ~= "null-ls" then
                            table.insert(buf_client_names, client.name)
                        end

                        if client.name == "copilot" then
                            copilot_active = true
                        end
                    end

                    -- add formatter
                    local sources = require "null-ls.sources"
                    local available_sources = sources.get_available(buf_ft)
                    local registered = {}

                    for _, source in ipairs(available_sources) do
                        for method in pairs(source.methods) do
                            registered[method] = registered[method] or {}
                            table.insert(registered[method], source.name)
                        end
                    end

                    local formatter = registered["NULL_LS_FORMATTING"]
                    local linter = registered["NULL_LS_DIAGNOSTICS"]

                    if formatter ~= nil then
                        vim.list_extend(buf_client_names, formatter)
                    end

                    if linter ~= nil then
                        vim.list_extend(buf_client_names, linter)
                    end

                    -- join client names with commas
                    local client_names_str = table.concat(buf_client_names, ", ")

                    -- check client_names_str if empty
                    local language_servers = ""

                    if #client_names_str ~= 0 then
                        language_servers = "%#SLLSP#" .. "[" .. client_names_str .. "]" .. "%*"
                    end

                    if copilot_active then
                        language_servers = language_servers .. "%#SLCopilot#" .. " " .. icons.git.Octoface .. "%*"
                    end

                    if #client_names_str == 0 and not copilot_active then
                        return ""
                    else
                        M.language_servers = language_servers
                        return language_servers
                    end
                end,
                padding = 0,
                separator = "%#SLSeparator#" .. " " .. "%*",
                cond = hide_in_width,
            }

            local filename = {
                'filename',
                path = 1, -- display relative path
                shorting_target = 40,
            }

            local branch = {
                'branch',
                icon = icons.git.branch,
                color = { gui = "bold" },
                cond = hide_in_width,
            }

            local diff = {
                "diff",
                symbols = {
                    added = icons.git.added .. " ",
                    modified = icons.git.modified .. " ",
                    removed = icons.git.removed .. " ",
                },
                cond = disable_filetype,
            }

            local diagnostics = {
                "diagnostics",
                symbols = {
                    error = icons.diagnostics.Error .. " ",
                    warn = icons.diagnostics.Warning .. " ",
                    info = icons.diagnostics.Information .. " ",
                    hint = icons.diagnostics.Hint .. " ",
                },
            }

            -- Change text color for lanuage_server output
            vim.api.nvim_set_hl(0, "SLLSP", { fg = "#616E88" })

            return {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    globalstatus = true,
                    component_separators = '|',
                    section_separators = '',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { branch, diff, diagnostics },
                    lualine_c = { filename },
                    lualine_x = { lsp, spaces, 'filetype' },
                    lualine_y = { 'location' },
                    lualine_z = { scrollbar }
                },
                extensions = { "fugitive", "lazy", "nvim-dap-ui", "trouble" },
            }
        end,
    },
    -- Plugin: Indentation guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            char = "▏",
            show_trailing_blankline_indent = false,
            show_first_indent_level = true,
            use_treesitter = true,
            use_treesitter_scope = 1,
            show_current_context = true,
            buftype_exclude = { "terminal", "nofile" },
            filetype_exclude = {
                "help",
                "startify",
                "dashboard",
                "packer",
                "neogitstatus",
                "NvimTree",
                "Trouble",
                "alpha",
                "lir",
                "Outline",
                "spectre_panel",
                "toggleterm",
                "DressingSelect",
            },
        },
    },
    -- Plugin: Web devicons
    {
        "kyazdani42/nvim-web-devicons",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            override_by_filename = {
                [".gitattributes"] = {
                    icon = "",
                    color = "#e24329",
                    cterm_color = "59",
                    name = "GitAttributes",
                },
                [".gitconfig"] = {
                    icon = "",
                    color = "#e24329",
                    cterm_color = "59",
                    name = "GitConfig",
                },
                [".gitignore"] = {
                    icon = "",
                    color = "#e24329",
                    cterm_color = "59",
                    name = "GitIgnore",
                },
                [".gitmodules"] = {
                    icon = "",
                    color = "#e24329",
                    cterm_color = "59",
                    name = "GitModules",
                },
                ["pp"] = {
                    icon = "",
                    color = "#FFA61A",
                    name = "Pp",
                },
                ["epp"] = {
                    icon = "",
                    color = "#FFA61A",
                    name = "Epp",
                },
                ["tf"] = {
                    icon = "󱁢",
                    color = "#5F43E9",
                    cterm_color = "57",
                    name = "Terraform",
                },
                ["astro"] = {
                    --  󱓟 
                    icon = "󱓞",
                    color = "#FF7E33",
                    name = "Astro",
                },
            },
        },
    },
}
