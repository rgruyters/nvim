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
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim", commit = "e4c2afb37d31e99b399425e102c58b091fbc16be" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim", commit = "2e0572cc35ecc117c0ab6dc0aa3132b109d61047" } -- Make comments pretty
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" } -- Commenting
  use { "akinsho/bufferline.nvim", commit = "d7b775a35be9c80ed591d3335b35ec84e5c5d81e" } -- Make bufferlines pretty
  use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  use { "nvim-lualine/lualine.nvim", commit = "655411fb7aa3cf4d46094132d684d815453f5043" } -- Blazing fast statusline
  use { "akinsho/toggleterm.nvim", commit = "9db6f98af4f700945cff0f4f34b92ec80ab67a2b" } -- Create Terminal windows
  use { "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" } -- Project window
  use { "lewis6991/impatient.nvim", commit = "2aa872de40dbbebe8e2d3a0b8c5651b81fe8b235" } -- Speedup loads
  use { "lukas-reineke/indent-blankline.nvim", commit = "4a58fe6e9854ccfe6c6b0f59abb7cb8301e23025" } -- Indentation guides
  use { "NvChad/nvim-colorizer.lua", commit = "6c8b1495c3d2034188cc67c18e2ae5e8343cd504" } -- Show colour codes

  -- UI
  use { "kyazdani42/nvim-web-devicons", commit = "2d02a56189e2bde11edd4712fea16f08a6656944" } -- provide webdev icons
  use { "kyazdani42/nvim-tree.lua", commit = "630305c233b815464d57bc253444610eb327d255" } -- File Explorer
  use { "goolord/alpha-nvim", commit = "79187fdf8f2a08a7174f237423198f6e75ae213a" } -- Greeter
  use { "folke/which-key.nvim", commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71" } -- Which key modal viewer
  use { "rcarriga/nvim-notify", commit = "4ef4c133fb92527b928603bf1ce43e729d09db50" } -- Notification window
  use { "folke/todo-comments.nvim", commit = "98b1ebf198836bdc226c0562b9f906584e6c400e" } -- highlight todo comments
  use { "kylechui/nvim-surround", commit = "78f10536d30a4f86155354636335263a0e6a7891" } -- Surround selections
  use {
    "SmiteshP/nvim-navic",
    commit = "94bf6fcb1dc27bdad230d9385da085e72c390019",
    requires = "neovim/nvim-lspconfig",
  } -- Winbar component show current code context

  -- Colorschemes
  use { "shaunsingh/nord.nvim" } -- Nord theme: My theme of choise

  -- cmp plugins
  use { "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" } -- The completion plugin
  use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" } -- path completions
  use { "hrsh7th/cmp-cmdline", commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252" }  -- cmdline completions
  use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" } --snippet engine
  use { "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" } -- enable LSP
  -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  use { "williamboman/mason.nvim", commit = "e61d2b7ba0ed392f6851bcdd4ed992694d4f4810" } -- Portable package manager for Neovim
  use { "williamboman/mason-lspconfig.nvim", commit = "a7971cdd755c737f5da5bca001299791c42a4a3b" } -- Bridge between LSP en Mason
  use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" } -- for formatters and linters
  use { "RRethy/vim-illuminate", commit = "6bfa5dc069bd4aa8513a3640d0b73392094749be" } -- Highlight words
  use { "stevearc/aerial.nvim", commit = "67bddeca28c476731ed5da64876b7f71d01190d1" } -- code outline window
  use { "j-hui/fidget.nvim", commit  = "46d1110435f1f023c22fa95bb10b3906aecd7bde" } -- UI LSP progress
  use { "folke/trouble.nvim", commit = "da61737d860ddc12f78e638152834487eabf0ee5" } -- Diagnostics viewer

  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "8c563017200bebd76153feb1046ecdf2db26c9d4" } -- Fuzzy finder

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", commit = "07b722157f10664c46ab0f457d6ea8e62bde75a7" } -- Highlight and parser

  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "4883988cf8b623f63cc8c7d3f11b18b7e81f06ff" } -- Superfast Git decorations

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
    commit = "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96",
    run = "cd app && npm install",
    ft = "markdown",
  } -- Markdown previewer

  -- Alignment
  use { "Vonr/align.nvim", commit = "368343964ac6d30f913bb46c272fea1c4d477bc5" } -- Aligning lines

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
