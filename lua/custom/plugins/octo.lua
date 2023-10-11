return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  dependencies = {
    'plenary.nvim',
    'telescope.nvim',
    'nvim-web-devicons',
  },
  opts = {
    enable_builtin = true,
  },
  config = function(_, opts)
    require('octo').setup(opts)
    vim.cmd([[hi OctoEditable guibg=none]])
  end,
  keys = {
    { '<leader>o', '<cmd>Octo<cr>', desc = 'Octo' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
