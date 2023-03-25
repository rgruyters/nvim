return {
    -- Fugitive, from the godfather of Vim
    { "tpope/vim-fugitive",
        init = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus"} )
            vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git('push') end, { desc = "[G]it [p]ush"} )
            vim.keymap.set("n", "<leader>gP", function() vim.cmd.Git('pull') end, { desc = "Git [P]ull"} )
        end,
        event = "VeryLazy" },
    -- Superfast Git decorations
    { "lewis6991/gitsigns.nvim", event = "VeryLazy" },
}
