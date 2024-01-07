return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
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
    init = function()
      vim.cmd.colorscheme('rose-pine')
    end,
  },
}
