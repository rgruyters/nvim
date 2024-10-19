return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    -- See `:help lualine.txt`
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local icons = require('custom.icons')

      vim.o.laststatus = vim.g.lualine_laststatus

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
          globalstatus = vim.o.laststatus == 3,
          component_separators = { left = '|', right = '' },
          section_separators = '',
          disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { filename },
          lualine_x = { spaces, 'filetype' },
          lualine_y = { 'location' },
          lualine_z = { 'progress' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { filename },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { 'fugitive', 'lazy', 'nvim-dap-ui', 'trouble' },
      }
    end,
  },
}
