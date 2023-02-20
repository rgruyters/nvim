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
