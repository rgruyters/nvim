return {
  'telescope.nvim',
  dependencies = {
    'ahmedkhalf/project.nvim',
    event = 'VimEnter',
    cmd = 'Telescope projects',
    keys = {
      { '<leader>fp', '<cmd>Telescope projects<CR>', desc = '[F]ind [P]rojects' },
    },
    opts = {
      detection_methods = { 'pattern' },
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)
      require('telescope').load_extension('projects')
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
