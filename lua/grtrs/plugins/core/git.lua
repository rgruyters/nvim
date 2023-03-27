return {
    -- Plugin: Fugitive, from the godfather of Vim
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        init = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus"} )
            vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git('push') end, { desc = "[G]it [p]ush"} )
            vim.keymap.set("n", "<leader>gP", function() vim.cmd.Git('pull') end, { desc = "Git [P]ull"} )
        end,
        event = "VeryLazy" },
    -- Plugin: Superfast Git decorations
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            },

            on_attach = function()
                local gs = package.loaded.gitsigns
                -- Navigation
                vim.keymap.set('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                vim.keymap.set('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true})
            end
        }
    },
}
