-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [']quote
--  - ci'  - [C]hange [I]nside [']quote
return {
  'echasnovski/mini.ai',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    n_lines = 500,
  },
  config = function(_, opts)
    require('mini.ai').setup(opts)
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
