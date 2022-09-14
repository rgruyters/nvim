local keymap = vim.keymap.set

local opts = { silent = true }

-- Git
keymap("n", "<leader>gg", "<cmd>LazyGit<CR>", opts)
keymap("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", opts)
