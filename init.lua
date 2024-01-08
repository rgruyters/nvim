-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
-- https://github.com/folke/lazy.nvim
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Setting options ]]
-- load options here, before lazy init plugins
-- this is needed to make sure options will be loaded correctly
require('kickstart.options')
require('custom.options')

-- NOTE: Here is where you install your plugins.
--       You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--  as they will be available in your neovim runtime.
require('lazy').setup({
  checker = { enabled = false }, -- do not check automatically for plugin updates
  defaults = {
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- Core kickstart plugins
  { import = 'kickstart.core' },

  -- [[ Configure LSP ]]
  { import = 'kickstart.plugins.lsp' },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  --
  -- require 'kickstart.plugins.autoformat',
  require('kickstart.plugins.debug'),

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --       You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --       up-to-date with whatever is in the kickstart repo.
  --
  { import = 'custom.plugins' },
  { import = 'custom.extras' },
}, {
  change_detection = { notify = false }, -- disable changes notifications
})

-- [[ Basic Keymaps ]]
require('kickstart.keymaps')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
