local keymap = vim.keymap.set

local opts = { silent = true }

-- TroubleToggle
keymap("n", "<leader>xx", "<cmd>TroubleToggle<CR>", opts)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", opts)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", opts)
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<CR>", opts)
