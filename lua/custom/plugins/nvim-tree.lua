return {
  'nvim-tree/nvim-tree.lua',
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus' },
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle Nvim Tree Explorer' },
  },
  config = function()
    require('nvim-tree').setup()
  end,
}
