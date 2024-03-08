return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    -- See `:help lualine.txt`
    opts = function()
      local icons = require('custom.icons')

      local filename = {
        'filename',
        path = 1, -- display relative path
        shorting_target = 40,
      }

      -- show number of spaces that is used for current buffer with additional icon
      local spaces = {
        function()
          return icons.misc.Spaces .. ' ' .. vim.api.nvim_get_option_value('shiftwidth', { buf = 0 })
        end,
      }

      return {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '|', right = '' },
          section_separators = '',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { filename },
          lualine_x = { spaces, 'filetype' },
          lualine_y = { 'location' },
          lualine_z = { 'progress' },
        },
        extensions = { 'fugitive', 'lazy', 'nvim-dap-ui', 'trouble' },
      }
    end,
  },
}
