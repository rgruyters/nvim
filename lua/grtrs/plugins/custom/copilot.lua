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
        },
        config = function()
            require("copilot").setup({
                filetypes = {
                    lua = true,
                    python = true,
                    terraform = true,
                    go = true,
                    puppet = true,
                    ["*"] = false,
                },
            })
        end,
    },
    -- Plugin: GitHub Copilot completion integration
    {
        "zbirenbaum/copilot-cmp",
        dependencies = {
            "copilot.lua",
            "nvim-cmp",
        },
        config = function(_, opts)
            local copilot_cmp = require("copilot_cmp")
            copilot_cmp.setup(opts)
            -- attach cmp source whenever copilot attaches
            -- fixes lazy-loading issues with the copilot cmp source
            require("grtrs.functions").on_attach(function(client)
                if client.name == "copilot" then
                    copilot_cmp._on_insert_enter()
                end
            end)
        end,
    },
}
