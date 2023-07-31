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
        event = { "InsertEnter", "LspAttach" },
        dependencies = {
            "zbirenbaum/copilot-cmp",
            dependencies = {
                "copilot.lua",
            },
            config = function()
                local copilot_cmp = require("copilot_cmp")
                copilot_cmp.setup()
                -- attach cmp source whenever copilot attaches
                -- fixes lazy-loading issues with the copilot cmp source
                require("grtrs.functions").on_attach(function(client)
                    if client.name == "copilot" then
                        copilot_cmp._on_insert_enter()
                    end
                end)
            end,
        },
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "copilot" } }))
        end,
    },
}
