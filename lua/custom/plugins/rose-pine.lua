return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    opts = {
      dark_variant = 'moon',

      highlight_groups = {
        -- change background color to the same color as for terminal
        Normal = { bg = '#1e1e2e' },

        -- vim-illuminate custom colors
        IlluminatedWordText = { bg = 'highlight_med', blend = 40 },
        IlluminatedWordRead = { bg = 'highlight_med', blend = 40 },
        IlluminatedWordWrite = { bg = 'highlight_med', blend = 40 },

        -- indent-blankline.nvim custom colors
        IblIndent = { fg = 'overlay' },
        IblScope = { fg = 'foam' },

        -- Give Telescope titles own color
        TelescopeTitle = { fg = "base", bg = "love" },
        TelescopePromptTitle = { fg = "base", bg = "pine" },
        TelescopePreviewTitle = { fg = "base", bg = "iris" },
      },
    },
    init = function()
      vim.cmd.colorscheme('rose-pine')
    end,
  },
}
