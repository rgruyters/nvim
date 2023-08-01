return {
    -- Plugin: GitHub Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                lua = true,
                python = true,
                terraform = true,
                go = true,
                puppet = true,
                ["*"] = false,
            },
        },
    },
    -- Plugin: GitHub Copilot completion integration
    {
        "nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "zbirenbaum/copilot-cmp",
            dependencies = {
                "copilot.lua",
            },
            opts = {
                event = { "InsertEnter", "LspAttach" },
                fix_pairs = true,
            },
            config = function(_, opts)
                local copilot_cmp = require("copilot_cmp")
                copilot_cmp.setup(opts)
                -- attach cmp source whenever copilot attaches
                -- fixes lazy-loading issues with the copilot cmp source
                require("custom.functions").on_attach(function(client)
                    if client.name == "copilot" then
                        copilot_cmp._on_insert_enter()
                    end
                end)

                -- local cmp = require('cmp')
                -- local config = cmp.get_config()
                -- table.insert(config.sources, { name = 'copilot' } )
                -- cmp.setup(config)
            end,
        },
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "copilot" } }))
        end,
    },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
