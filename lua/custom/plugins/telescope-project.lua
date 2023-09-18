return {
  'telescope.nvim',
  dependencies = {
    'ahmedkhalf/project.nvim',
    keys = {
      { '<leader>fp', '<cmd>Telescope projects<CR>', desc = '[F]ind [P]rojects' },
    },
    opts = {
      active = true,
      on_config_done = nil,
      manual_mode = false,
      detection_methods = { 'pattern' },
      patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },
      show_hidden = true,
      silent_chdir = true,
      ignore_lsp = {},
      datapath = vim.fn.stdpath('data'),
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)
      require('telescope').load_extension('projects')
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
