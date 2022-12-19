-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
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
local packer_loaded, packer = pcall(require, "packer")
if not packer_loaded then
    return
end

-- Have packer use a popup window
packer.init({
    snapshot_path = vim.fn.stdpath("config") .. "/snapshots",
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
    use { "wbthomason/packer.nvim" } -- Have packer manage itself

    -- Colorschemes
    use { "catppuccin/nvim", as = "catppuccin" } -- catppuccin theme

    -- UI
    use {
        "akinsho/bufferline.nvim",
        tag = "v3.*",
        after = "catppuccin",
        requires = "kyazdani42/nvim-web-devicons",
    } -- Make bufferlines pretty

    use { "nvim-lualine/lualine.nvim",
        after = "catppuccin",
        requires = "kyazdani42/nvim-web-devicons",
    } -- Blazing fast statusline

    -- Standard plugins
    use { "numToStr/Comment.nvim" } -- Make comments pretty
    use { "JoosepAlviste/nvim-ts-context-commentstring" } -- Commenting
    use { "Vonr/align.nvim" } -- Aligning lines
    use { "mbbill/undotree" } -- Undotree

    use { "moll/vim-bbye" } -- Close buffers by keeping layout
    use { "lukas-reineke/indent-blankline.nvim" } -- Indentation guides

    use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" } -- highlight todo comments
    use { "kylechui/nvim-surround" } -- Surround selections

    use({ "NvChad/nvim-colorizer.lua" }) -- Show colour codes

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
    use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
    use { "RRethy/vim-illuminate" } -- Highlight words
    use { "onsails/lspkind-nvim" } -- VSCode icons

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- Highlight and parser
    use { "nvim-treesitter/nvim-treesitter-context" } -- Show context

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = { "nvim-lua/plenary.nvim" },
    } -- Fuzzy finder
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        cond = vim.fn.executable "make" == 1
    } -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { "ahmedkhalf/project.nvim" } -- Project window

    use { "ThePrimeagen/harpoon" } -- Buffer management

    -- Git
    use { "lewis6991/gitsigns.nvim" } -- Superfast Git decorations
    use {
        "f-person/git-blame.nvim",
        config = function()
            vim.g.gitblame_enabled = 0
            vim.g.gitblame_message_template = "<sha> • <summary> • <date> • <author>"
        end
    } -- Git Blame
    use { "kdheepak/lazygit.nvim" } -- Lazygit for Neovim

    -- DAP
    use { "mfussenegger/nvim-dap" }
    use { "rcarriga/nvim-dap-ui" }
    use { "ravenxrz/DAPInstall.nvim" }
    use { "theHamsta/nvim-dap-virtual-text" }

    -- Markdown
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    } -- Markdown previewer

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
