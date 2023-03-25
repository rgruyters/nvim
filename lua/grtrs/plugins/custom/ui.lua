return {
    -- Show colour codes
    { "NvChad/nvim-colorizer.lua", lazy = true },
    -- Alternative File Explorer
    {
        "tamago324/lir.nvim",
        keys = {
            { "<leader>e", "<cmd>execute 'e ' .. expand('%:p:h')<CR>", desc = "Lir File Explorer"}
        }
    },
    { "tamago324/lir-git-status.nvim", dependencies = "tamago324/lir.nvim" },
}
