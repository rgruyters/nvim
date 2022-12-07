local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    snapshot_path = fn.stdpath("config") .. "/snapshots",
    max_jobs = 50,
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- Important plugins
    use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
    use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("grtrs.configs.impatient")
        end
    }) -- Speedup loads

    -- Colorschemes
    use({ "catppuccin/nvim", as = "catppuccin",
        config = function()
            require("grtrs.configs.colorscheme")
        end
    }) -- catppuccin theme

    -- Standard plugins
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("grtrs.configs.comment")
        end
    }) -- Make comments pretty

    use({ "JoosepAlviste/nvim-ts-context-commentstring" }) -- Commenting
    use({ "Vonr/align.nvim" }) -- Aligning lines
    use({ "mbbill/undotree" }) -- Undotree

    -- UI
    use({
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        after = "catppuccin",
        require = "kyazdani42/nvim-web-devicons",
        config = function()
            require("grtrs.configs.bufferline")
        end
    }) -- Make bufferlines pretty

    use({ "nvim-lualine/lualine.nvim",
        after = "catppuccin",
        require = "kyazdani42/nvim-web-devicons",
        config = function()
            require("grtrs.configs.lualine")
        end
    }) -- Blazing fast statusline

    use({ "moll/vim-bbye" }) -- Close buffers by keeping layout
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("grtrs.configs.indentline")
        end
    }) -- Indentation guides
    use({ "kyazdani42/nvim-web-devicons" }) -- provide webdev icons

    use({
        "folke/todo-comments.nvim",
        config = function()
            require("grtrs.configs.todo-comments")
        end
    }) -- highlight todo comments
    use({
        "kylechui/nvim-surround",
        config = function()
            require("grtrs.configs.surround")
        end
    }) -- Surround selections

    use({
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("grtrs.configs.colorizer")
        end
    }) -- Show colour codes

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
    use({ "hrsh7th/cmp-buffer" }) -- buffer completions
    use({ "hrsh7th/cmp-path" }) -- path completions
    use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
    use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter

    -- snippets
    use({ "L3MON4D3/LuaSnip" }) --snippet engine
    use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

    -- LSP
    use({ "williamboman/mason.nvim" }) -- Portable package manager for Neovim
    use({ "williamboman/mason-lspconfig.nvim" }) -- Bridge between LSP en Mason
    use({ "neovim/nvim-lspconfig" }) -- enable LSP
    use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
    use({
        "RRethy/vim-illuminate",
        config = function()
            require("grtrs.configs.illuminate")
        end
    }) -- Highlight words
    use({ "folke/trouble.nvim" }) -- Diagnostics viewer
    use({ "onsails/lspkind-nvim" }) -- VSCode icons

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("grtrs.configs.treesitter")
        end
    }) -- Highlight and parser
    use({
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("grtrs.configs.treesitter-context")
        end
    }) -- Show context

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        config = function()
            require("grtrs.configs.telescope")
        end
    }) -- Fuzzy finder
    use({
        "ahmedkhalf/project.nvim",
        config = function()
            require("grtrs.configs.project")
        end
    }) -- Project window
    use({
        "ThePrimeagen/harpoon",
        config = function()
            require("grtrs.configs.harpoon")
        end
    }) -- Buffer management

    -- Git
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("grtrs.configs.gitsigns")
        end
    }) -- Superfast Git decorations

    use({
        "f-person/git-blame.nvim",
        config = function()
            require("grtrs.configs.git-blame")
        end
    }) -- Git Blame

    use({ "kdheepak/lazygit.nvim" }) -- Lazygit for Neovim

    -- DAP
    use({ "mfussenegger/nvim-dap" })
    use({ "rcarriga/nvim-dap-ui" })
    use({ "ravenxrz/DAPInstall.nvim" })
    use({ "theHamsta/nvim-dap-virtual-text" })

    -- Markdown
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    }) -- Markdown previewer

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
