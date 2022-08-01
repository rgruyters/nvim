local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" } -- Make comments pretty
  use { "JoosepAlviste/nvim-ts-context-commentstring" } -- Commenting
  use { "akinsho/bufferline.nvim" } -- Make bufferlines pretty
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" } -- Blazing fast statusline
  use { "akinsho/toggleterm.nvim" } -- Create Terminal windows
  use { "ahmedkhalf/project.nvim" } -- Project window
  use { "lewis6991/impatient.nvim" } -- Speedup loads
  use { "lukas-reineke/indent-blankline.nvim" } -- Indentation guides
  use { "NvChad/nvim-colorizer.lua" } -- Show colour codes

  -- UI
  use { "kyazdani42/nvim-web-devicons" } -- provide webdev icons
  use { "kyazdani42/nvim-tree.lua" } -- File Explorer
  use { "goolord/alpha-nvim" } -- Greeter
  use { "folke/which-key.nvim" } -- Which key modal viewer
  use { "rcarriga/nvim-notify" } -- Notification window
  use { "folke/todo-comments.nvim" } -- highlight todo comments
  use { "kylechui/nvim-surround" } -- Surround selections
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  } -- Winbar component show current code context

  -- Colorschemes
  use { "shaunsingh/nord.nvim" } -- Nord theme: My theme of choise

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "hrsh7th/cmp-cmdline" }  -- cmdline completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  use { "williamboman/mason.nvim" } -- Portable package manager for Neovim
  use { "williamboman/mason-lspconfig.nvim" } -- Bridge between LSP en Mason
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" } -- Highlight words
  use { "stevearc/aerial.nvim" } -- code outline window
  use { "j-hui/fidget.nvim" } -- UI LSP progress
  use { "folke/trouble.nvim" } -- Diagnostics viewer

  -- Telescope
  use { "nvim-telescope/telescope.nvim" } -- Fuzzy finder

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" } -- Highlight and parser

  -- Git
  use { "lewis6991/gitsigns.nvim" } -- Superfast Git decorations

  -- Copilot
  -- use {"github/copilot.vim"}
  -- use {
  --   "zbirenbaum/copilot.lua",
  --   event = { "VimEnter" },
  --   config = function()
  --     vim.defer_fn(function()
  --       require("user.copilot")
  --     end, 100)
  --   end,
  -- }
  -- use {
  --   "zbirenbaum/copilot-cmp",
  --   module = "copilot_cmp",
  -- }
  use {
    "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        ignored_file_types = { -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
          mardown = true,
        },
      }
    end,

    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  } -- Tabnine AI completion

  -- DAP
  -- use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
  -- use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
  -- use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  } -- Markdown previewer

  -- Alignment
  use { "Vonr/align.nvim" } -- Aligning lines

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
