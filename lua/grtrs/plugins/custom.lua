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

    {
        "cshuaimin/ssr.nvim",
        -- init is always executed during startup, but doesn't load the plugin yet.
        init = function()
            vim.keymap.set({ "n", "x" }, "<leader>cR", function()
                -- this require will automatically load the plugin
                require("ssr").open()
            end, { desc = "Structural Replace" })
        end,
    },

    -- Buffer management
    { "ThePrimeagen/harpoon", lazy = true },

    -- Git
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

    -- DAP
    { "mfussenegger/nvim-dap", lazy = true },
    { "mfussenegger/nvim-dap-python", lazy = true },
    { "rcarriga/nvim-dap-ui", lazy = true },
    { "theHamsta/nvim-dap-virtual-text", lazy = true },
    {
        "nvim-telescope/telescope-dap.nvim",
        config = function()
            require('telescope').load_extension('dap')
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-nvim-dap").setup({ automatic_setup = true })
        end
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
}
