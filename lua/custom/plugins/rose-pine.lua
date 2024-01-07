return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      dark_variant = 'moon',
      disable_background = true, -- In case of transparent terminals

      highlight_groups = {
        IlluminatedWordRead = { bg = 'overlay', blend = 30 },

        -- indent-blankline.nvim custom colors
        IblIndent = { fg = 'overlay' },
        IblScope = { fg = 'text' },
      },
    },
  },
}
