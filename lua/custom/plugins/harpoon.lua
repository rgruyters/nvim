return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  config = function(_, opts)
    local harpoon = require('harpoon')

    harpoon:setup(opts)

    vim.keymap.set('n', '<leader>mm', function() harpoon:list():append() end, { desc = 'Harpoon: Add to list'})
    vim.keymap.set('n', '<leader>mt', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: Quick menu' })
    vim.keymap.set('n', '<leader>mi', function() harpoon:list():select(1) end, { desc = 'Harpoon: Select item 1'})
    vim.keymap.set('n', '<leader>mj', function() harpoon:list():select(2) end, { desc = 'Harpoon: Select item 2'})
    vim.keymap.set('n', '<leader>mk', function() harpoon:list():select(3) end, { desc = 'Harpoon: Select item 3'})
    vim.keymap.set('n', '<leader>ml', function() harpoon:list():select(4) end, { desc = 'Harpoon: Select item 4'})

    vim.keymap.set('n', '[h', function() harpoon:list():prev() end, { desc = 'Harpoon: Previous'})
    vim.keymap.set('n', ']h', function() harpoon:list():prev() end, { desc = 'Harpoon: Next'})
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
