-- Automatically install packer
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin", lazy = false },
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        dependencies = "kyazdani42/nvim-web-devicons",
    }, -- Make bufferlines pretty
    { "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = "kyazdani42/nvim-web-devicons",
    }, -- Blazing fast statusline

    "numToStr/Comment.nvim", -- Make comments pretty
    "JoosepAlviste/nvim-ts-context-commentstring", -- Commenting
    "Vonr/align.nvim", -- Aligning lines
    "mbbill/undotree", -- Undotree
    -- Undotree
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { silent = true })
        end
    },

    "lukas-reineke/indent-blankline.nvim", -- Indentation guides

    { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" }, -- highlight todo comments
    "kylechui/nvim-surround", -- Surround selections

    "NvChad/nvim-colorizer.lua", -- Show colour codes

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            -- 'rafamadriz/friendly-snippets',
        },
    },
    "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
    "RRethy/vim-illuminate", -- Highlight words
    "onsails/lspkind-nvim", -- VSCode icons

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Highlight and parser
    "nvim-treesitter/nvim-treesitter-context", -- Show context

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
    }, -- Fuzzy finder
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    }, -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    "ahmedkhalf/project.nvim", -- Project window

    "ThePrimeagen/harpoon", -- Buffer management

    -- Git
    "lewis6991/gitsigns.nvim", -- Superfast Git decorations
    {
        "f-person/git-blame.nvim",
        init = function()
            vim.g.gitblame_enabled = 0
            vim.g.gitblame_message_template = "<sha> • <summary> • <date> • <author>"
    -- Lazygit for Neovim
    {
        "kdheepak/lazygit.nvim",
        config = function()
           vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "[L]azy [G]it"})
        end
    },

    -- DAP
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "ravenxrz/DAPInstall.nvim",
    "theHamsta/nvim-dap-virtual-text",

    -- Markdown
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    }, -- Markdown previewer
})
