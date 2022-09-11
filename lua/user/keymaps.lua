-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- File Explorer
keymap("n", "<leader>pv", ":Ex<CR>", opts)

-- UndoTree
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>fp", "<cmd>lua require('telescope.builtin').projects()<CR>", opts)
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>LazyGit<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)

-- Harpoon
keymap("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts) -- Harpoon add marker
keymap("n", "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts) -- Harpoon UI
keymap("n", "<leader>.","<cmd>lua require('harpoon.ui').nav_next()<CR>", opts ) -- Harpoon Next
keymap("n", "<leader>,", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", opts) -- Harpoon Prev

-- Insert --

-- Visual --
-- Better paste
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts) -- Move visual up
keymap("v", "K", ":m '<-2<CR>gv=gv", opts) -- Move visual down

-- Align --
keymap("x", "aa", function() require'align'.align_to_char(1, true) end, opts) -- Aligns to 1 character, looking left
keymap("x", "as", function() require'align'.align_to_char(2, true, true) end, opts) -- Aligns to 2 characters, looking left and with previews
keymap("x", "aw", function() require'align'.align_to_char(false, true, true) end, opts) -- Aligns to a string, looking left and with previews
keymap("x", "ar", function() require'align'.align_to_char(true, true, true) end, opts) -- Aligns to a Lua pattern, looking left and with previews

keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
