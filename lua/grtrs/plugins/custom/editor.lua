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
    -- Highlight words
    { "RRethy/vim-illuminate", lazy = true },
    -- Buffer management
    { "ThePrimeagen/harpoon", lazy = true },
}
