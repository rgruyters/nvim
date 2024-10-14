--
-- ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓    ▄▄▄▄   ▄▄▄█████▓ █     █░
--  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒   ▓█████▄ ▓  ██▒ ▓▒▓█░ █ ░█░
-- ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░   ▒██▒ ▄██▒ ▓██░ ▒░▒█░ █ ░█
-- ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██    ▒██░█▀  ░ ▓██▓ ░ ░█░ █ ░█
-- ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒   ░▓█  ▀█▓  ▒██▒ ░ ░░██▒██▓
-- ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░   ░▒▓███▀▒  ▒ ░░   ░ ▓░▒ ▒
-- ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░   ▒░▒   ░     ░      ▒ ░ ░
--    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░       ░    ░   ░        ░   ░
--          ░    ░  ░    ░ ░        ░   ░         ░       ░                   ░
--                                 ░                           ░
--

-- This Neovim configuration is based on kickstart.nvim project (https://github.com/nvim-lua/kickstart.nvim)
-- Feel free to poke around and get inspired. I use Neovim BTW™

-- [[ Kickstart Options ]]
require('kickstart.options')
-- [[ Custom Options ]]
require('custom.options')
-- [[ Kickstart Keymaps ]]
require('kickstart.keymaps')
-- [[ Kickstart Autocommands]]
require('kickstart.autocommands')

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  require('kickstart.plugins.colorscheme'), -- add some extra color to my PDE
  require('kickstart.plugins.vim-sleuth'), -- Detect tabstop and shiftwidth automatically
  require('kickstart.plugins.gitsigns'), -- Adds git related signs to the gutter, as well as utilities for managing changes
  require('kickstart.plugins.whichkey'), -- Keys overlay
  require('kickstart.plugins.telescope'), -- Fuzzy find / file explorer
  require('kickstart.plugins.lsp'), -- Language Server Protocol Plugins
  require('kickstart.plugins.conform'), -- Formatting
  require('kickstart.plugins.nvim-cmp'), -- Completion
  require('kickstart.plugins.todo-comments'), -- Highlight todo, notes, etc in comments
  require('kickstart.plugins.treesitter'), -- Highlight, edit, and navigate code

  -- Additional kickstart plugins
  require('kickstart.plugins.lualine'),
  require('kickstart.plugins.autopairs'),
  require('kickstart.plugins.debug'),
  require('kickstart.plugins.indent_line'),
  require('kickstart.plugins.lint'),

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
  { import = 'custom.extras' },
}, {
  change_detection = { notify = false }, -- disable changes notifications
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
