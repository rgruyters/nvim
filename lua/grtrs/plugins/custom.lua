return {
    -- Undotree
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
        },
    },

    -- Close buffers by keeping layout
    { "moll/vim-bbye" },

    -- Show colour codes
    { "NvChad/nvim-colorizer.lua", lazy = true },

    -- Highlight words
    { "RRethy/vim-illuminate", lazy = true },

    -- A list of diagnostics, references, telescope results, quickfix and
    -- location lists to help you solve your problems
    { "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
        },
    },

    {
        "cshuaimin/ssr.nvim",
        keys = {
            { "<leader>cR", function() require("ssr").open() end, mode = { "n", "x" }, desc = "Structural Replace" },
        },
    },

    -- Buffer management
    { "ThePrimeagen/harpoon", lazy = true },

    -- Git
    -- Github extention for Git (fugitive.vim)
    { "tpope/vim-rhubarb" },
    { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },
    -- View Git messages in a window
    { "rhysd/git-messenger.vim" },
    -- Lazygit for Neovim
    {
        "kdheepak/lazygit.nvim",
        keys = {
            { "<leader>lg", "<cmd>LazyGit<CR>", desc = "[L]azy [G]it" },
        },
    },

    -- Markdown Previewer
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- Alternative File Explorer
    {
        "tamago324/lir.nvim",
        keys = {
            { "<leader>e", "<cmd>execute 'e ' .. expand('%:p:h')<CR>", desc = "Lir File Explorer"}
        }
    },
    { "tamago324/lir-git-status.nvim", dependencies = "tamago324/lir.nvim" },

    -- GitHub Copilot
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
