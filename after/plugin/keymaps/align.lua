local keymap = vim.keymap.set

local opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Align --
keymap("x", "aa", "<cmd>lua require('align').align_to_char(1, true)<CR>", opts) -- Aligns to 1 character, looking left
keymap("x", "as", "<cmd>lua require('align').align_to_char(2, true, true)<CR>", opts) -- Aligns to 2 characters, looking left and with previews
keymap("x", "aw", "<cmd>lua require('align').align_to_char(false, true, true)<CR>", opts) -- Aligns to a string, looking left and with previews
keymap("x", "ar", "<cmd>lua require('align').align_to_char(true, true, true)<CR>", opts) -- Aligns to a Lua pattern, looking left and with previews
