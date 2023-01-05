# My Personalized Development Environment

This is my personalized config and plugins for [Neovim](https://neovim.io).

## Install Neovim

Install Neovim from a package manager of your choice e.g. brew, apt, pacman
etc.. For this config we need to have Neovim version 0.8 or higher.

On a Mac:

```sh
brew install neovim # For Neovim version 0.8
brew install --HEAD neovim # For Neovim Nightly (currently 0.9-dev)
```

If you would like to make sure Neovim only updates when you want it to
than I recommend installing from source:

```sh
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
```

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
git clone https://github.com/rgruyters/nvim.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers the
next time you open Neovim)

**NOTE** Checkout this file for some predefined keymaps:
[keymaps](https://github.com/rgruyters/nvim/blob/main/lua/grtrs/keymaps.lua)

## Get healthy

Open `nvim` and enter the following:

```neovim
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python
and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On Mac `pbcopy` should be builtin

- On Ubuntu

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

Next we need to install Python support (node is optional)

- Neovim python support

  ```sh
  pip install pynvim
  ```

- Neovim node support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` for Telescope to work:

- Ripgrep

  ```sh
  brew install ripgrep # for Mac
  sudo apt install ripgrep # for Ubuntu
  ```

---

**NOTE** make sure you have [node](https://nodejs.org/en/) installed, I
recommend a node manager like [fnm](https://github.com/Schniz/fnm).

## Fonts

I recommend using the following repo to get a "[Nerd Font](https://github.com/ryanoasis/nerd-fonts)"
(Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Configuration

### LSP

When opening a file [LSP zero](https://github.com/VonHeikemen/lsp-zero.nvim)
will notify when a lspserver is available for the current file. You can also
install a LSP yourself by using:

```neovim
:Mason
```

and press `i` on the Language Server you wish to install

Next you will need to add the server to this list: [servers](https://github.com/rgruyters/nvim/blob/main/lua/grtrs/lsp/init.lua)

### Formatters and linters

Make sure the formatter or linter is installed and add it to this setup function:
[null-ls](https://github.com/rgruyters/nvim/blob/main/lua/grtrs/lsp/null-ls.lua)

**NOTE** Some are already setup as examples, remove them if you want

### Plugins

You can install new plugins here: [plugins](https://github.com/rgruyters/nvim/blob/main/lua/grtrs/plugins.lua)

- [lazy](https://github.com/folke/lazy.nvim)
- [plenary](https://github.com/nvim-lua/plenary.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [vim-bbye](https://github.com/moll/vim-bbye)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [project.nvim](https://github.com/ahmedkhalf/project.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [nvim-colorizer](https://github.com/NvChad/nvim-colorizer.lua)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim)
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- [vim-illuminate](https://github.com/RRethy/vim-illuminate)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [git-blame.nvim](https://github.com/f-person/git-blame.nvim)
- [lazygit](https://github.com/kdheepak/lazygit.nvim)
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [nvim-surround](https://github.com/kylechui/nvim-surround)
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
- [lspkind-nvim](https://github.com/onsails/lspkind-nvim)
- [harpoon](https://github.com/ThePrimeagen/harpoon)
- [align.nvim](https://github.com/Vonr/align.nvim)
- [undotree](https://github.com/mbbill/undotree)
- [catppucchin](https://github.com/catppuccin/nvim)

### Breaking changes

Some plugins will have breaking changes at some point. Here are some links with
more information:

- [nvim-treesitter breaking changes](https://github.com/nvim-treesitter/nvim-treesitter/issues/2293)
- [bufferline breaking changes](https://github.com/akinsho/bufferline.nvim/issues/387)
- [comments breaking changes](https://github.com/numToStr/Comment.nvim/issues/114)
- [nvim-cmp breaking changes](https://github.com/hrsh7th/nvim-cmp/issues/231)
- [luasnip breaking changes](https://github.com/L3MON4D3/LuaSnip/issues/81)
- [null-ls breaking changes](https://github.com/jose-elias-alvarez/null-ls.nvim/issues/344)
- [telescope breaking changes](https://github.com/nvim-telescope/telescope.nvim/issues/1470)
- [gitsigns breaking changes](https://github.com/lewis6991/gitsigns.nvim/issues/453)
- [nvim-surround breaking changes](https://github.com/kylechui/nvim-surround/issues/77)
- [catppuccin breaking changes](https://github.com/catppuccin/nvim/issues/260)

---

> The computing scientist's main challenge is not to get confused by the
> complexities of his own making.

\- Edsger W. Dijkstra
