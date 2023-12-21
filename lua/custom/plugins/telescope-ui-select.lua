return {
  'nvim-telescope/telescope-ui-select.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown({}),
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('ui-select')
  end,
}
