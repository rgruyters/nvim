return {
    -- Plugin: Git diff viewer
    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "VeryLazy",
        keys = {
            { "ch", "<cmd>diffget //2<CR>", desc = "Commit Left Side" },
            { "cl", "<cmd>diffget //3<CR>", desc = "Commit Right Side" },
        }
    },
    -- Plugin: View Git messages in a window
    { "rhysd/git-messenger.vim" },
    -- Plugin: Lazygit for Neovim
    {
        "kdheepak/lazygit.nvim",
        keys = {
            { "<leader>lg", "<cmd>LazyGit<CR>", desc = "[L]azy [G]it" },
        },
    },
}
