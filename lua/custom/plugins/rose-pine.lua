return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    opts = {
      dark_variant = 'moon',
      disable_background = true, -- Use terminal default background color (or transparency)

      highlight_groups = {
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
