-- Shorten function name
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

-- Set leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Disable arrow keys
keymap("", "<Up>", "<Nop>")
keymap("", "<Down>", "<Nop>")
keymap("", "<Left>", "<Nop>")
keymap("", "<Right>", "<Nop>")

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

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
keymap("n", "<leader>e", "<cmd>Ex<CR>", opts)

-- Better paste
keymap("v", "<leader>p", "\"_dP")
keymap("x", "<leader>p", "\"_dP")

-- Better Yank
keymap("n", "<leader>y", "\"+y")
keymap("v", "<leader>y", "\"+y")

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts) -- Move visual up
keymap("v", "K", ":m '<-2<CR>gv=gv", opts) -- Move visual down

-- Diagnostics
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local diag_opts = { noremap = true, silent = true }
vim.keymap.set("n", "gl", vim.diagnostic.open_float, diag_opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, diag_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, diag_opts)
