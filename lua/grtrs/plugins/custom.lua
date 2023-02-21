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
}
