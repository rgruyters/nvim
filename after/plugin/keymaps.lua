-- Disable arrow keys
vim.keymap.set('', '<Up>', '<cmd>echo "Use j"<CR>')
vim.keymap.set('', '<Down>', '<cmd>echo "Use k"<CR>')
vim.keymap.set('', '<Left>', '<cmd>echo "Use h"<CR>')
vim.keymap.set('', '<Right>', '<cmd>echo "Use l"<CR>')

-- Normal --
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { silent = true })

-- Navigate buffers
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next Buffer' }) -- move to next buffer
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous Buffer' }) -- move to previous buffer
vim.keymap.set('n', '<S-q>', ':bd!<CR>') -- delete current buffer

-- buffer bracket motion
vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Next Buffer' }) -- move to next buffer
vim.keymap.set('n', '[b', ':bprevious<CR>', { desc = 'Previous Buffer' }) -- move to previous buffer

-- File Explorer
vim.keymap.set('n', '<leader>pv', '<cmd>Ex<CR>', { desc = 'Open Netrw' })

-- Better paste
vim.keymap.set({ 'v', 'x' }, '<leader>p', '"_dP')

-- Better Yank
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true }) -- Move visual up
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true }) -- Move visual down

vim.keymap.set('n', '<leader>cf', '<cmd>Format<CR>', { desc = 'Format Buffer' })
