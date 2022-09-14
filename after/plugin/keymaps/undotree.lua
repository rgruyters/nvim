local keymap = vim.keymap.set

-- Silent keymap option
local opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- UndoTree
keymap("n", "<leader>u", "<cmd>UndotreeToggle<CR>", opts)
