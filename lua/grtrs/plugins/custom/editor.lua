return {
    -- Plugin: Undotree
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
        },
    },
    -- Plugin: Close buffers by keeping layout
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
    -- Plugin: Structual Search & Replace
    {
        "cshuaimin/ssr.nvim",
        keys = {
            { "<leader>cR", function() require("ssr").open() end, mode = { "n", "x" }, desc = "Structural Replace" },
        },
    },
    -- Plugin: Highlight words
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            delay =200,
            filetypes_denylist = {
                'fugitive',
                'lir',
                'TelescopePrompt',
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            -- disables illuminate on very large files as it slowd down the editor
            vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
                callback = function()
                    local line_count = vim.api.nvim_buf_line_count(0)
                    if line_count >= 5000 then
                        vim.cmd("IlluminatePauseBuf")
                    end
                end,
            })
        end,
    },
    { -- Plugin: schemastore
        "b0o/schemastore.nvim",
        lazy = true,
    },
}
