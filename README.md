# My Personalized Development Environment

This is my personalized config and plugins for [Neovim](https://neovim.io).

## Install Neovim

Install Neovim from a package manager of your choice e.g. brew, apt, pacman
etc.. For this config we need to have Neovim version 0.8 or higher.

On a Mac:

```sh
brew install neovim # For latest stable Neovim
brew install --HEAD neovim # For Neovim nightly version
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

-   On Mac `pbcopy` should be builtin

-   On Ubuntu

    ```sh
    sudo apt install xsel # for X11
    sudo apt install wl-clipboard # for wayland
    ```

Next we need to install Python support (node is optional)

-   Neovim python support

    ```sh
    pip install pynvim
    ```

-   Neovim node support

    ```sh
    npm i -g neovim
    ```

We will also need `ripgrep` for Telescope to work:

-   Ripgrep

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

### Kickstart

My setup is now build on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) as core setup.
All other changes are added to `lua/custom` folder or in `after/plugins`.

### LSP

To install a LSP, open "Mason" and find the list of all available LSP plugins.

```neovim
:Mason
```

and press `i` on the Language Server you wish to install. The current setup will
automatically enable the LSP for the particular file type.

### Formatters and linters

My setup uses some [conform.nvim](https://github.com/stevearc/conform.nvim) for
formatting and [nvim-lint](https://github.com/mfussenegger/nvim-lint) for
linting. Required plugins can be installed via [mason](https://github.com/williamboman/mason.nvim)

**NOTE** Some are already setup as examples, remove them if you want

### LSP Settings

Custom LSP settings can be added to [lua/custom/extras/lang](https://github.com/rgruyters/nvim/tree/main/lua/custom/extras/lang) as an own language file.

#### Additional Notes for LSPs

When using Puppet LSP (`puppet-editor-services`), additional packages are required before use. Common error message is
`An error occured while starting the Language Server`.

The following needs to be installed or available:

-   Puppet GEM (`gem install puppet`)

### Plugins

The current setup uses two files for installing and implementing plugins:

-   [init][1] - [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), minimum of plugins to use
-   [custom][2] - Any extra plugins that I want to use or test out

If you want to add more plugins, the best place is to add them in the
[custom][2] plugin folder.

The following plugins are availabile in the current setup:

-   [Comment.nvim](https://github.com/numToStr/Comment.nvim)
-   [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
-   [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
-   [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
-   [cmp-path](https://github.com/hrsh7th/cmp-path)
-   [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
-   [conform.nvim](https://github.com/stevearc/conform.nvim)
-   [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
-   [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
-   [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
-   [lazy](https://github.com/folke/lazy.nvim)
-   [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
-   [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
-   [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
-   [mason.nvim](https://github.com/williamboman/mason.nvim)
-   [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
-   [nvim-lint](https://github.com/mfussenegger/nvim-lint)
-   [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
-   [nvim-surround](https://github.com/kylechui/nvim-surround)
-   [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
-   [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
-   [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
-   [plenary](https://github.com/nvim-lua/plenary.nvim)
-   [project.nvim](https://github.com/ahmedkhalf/project.nvim)
-   [rose pine](https://github.com/rose-pine/neovim)
-   [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
-   [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
-   [undotree](https://github.com/mbbill/undotree)
-   [vim-fugitive](https://github.com/tpope/vim-fugitive)
-   [vim-sleuth](https://github.com/tpope/vim-sleuth)

### Breaking changes

Some plugins will have breaking changes at some point. Here are some links with
more information:

-   [nvim-treesitter breaking changes](https://github.com/nvim-treesitter/nvim-treesitter/issues/2293)
-   [comments breaking changes](https://github.com/numToStr/Comment.nvim/issues/114)
-   [nvim-cmp breaking changes](https://github.com/hrsh7th/nvim-cmp/issues/231)
-   [luasnip breaking changes](https://github.com/L3MON4D3/LuaSnip/issues/81)
-   [null-ls breaking changes](https://github.com/jose-elias-alvarez/null-ls.nvim/issues/344)
-   [telescope breaking changes](https://github.com/nvim-telescope/telescope.nvim/issues/1470)
-   [gitsigns breaking changes](https://github.com/lewis6991/gitsigns.nvim/issues/453)
-   [nvim-surround breaking changes](https://github.com/kylechui/nvim-surround/issues/77)

---

> The computing scientist's main challenge is not to get confused by the
> complexities of his own making.

\- Edsger W. Dijkstra

[1]: https://github.com/rgruyters/nvim/tree/main/init.lua
[2]: https://github.com/rgruyters/nvim/tree/main/lua/custom/plugins
