return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd.colorscheme "catppuccin-macchiato"
        end
    },

    -- Make bufferlines pretty
    {
        "akinsho/bufferline.nvim",
        lazy = true,
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    -- Blazing fast statusline
    { "nvim-lualine/lualine.nvim",
        lazy = true,
        dependencies = "kyazdani42/nvim-web-devicons",
    },

    -- Make comments pretty
    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end
    },

    -- Aligning lines
    { "Vonr/align.nvim", lazy = true },
    -- Autopair
    { "windwp/nvim-autopairs" },
    -- Indentation guides
    { "lukas-reineke/indent-blankline.nvim", lazy = true },

    -- highlight todo comments
    { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", lazy = true },
    -- Surround selections
    { "kylechui/nvim-surround", lazy = true },

    -- LSP
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        lazy = true,
    },

    -- Autocompletion
    { "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",

            -- Snippets
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        lazy = true,
    },

    -- for formatters and linters
    { "jose-elias-alvarez/null-ls.nvim", lazy = true },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", dependencies = "nvim-treesitter/nvim-treesitter-context", build = ":TSUpdate" },

    -- Telescope
    { "nvim-telescope/telescope.nvim", version = "*", dependencies = "nvim-lua/plenary.nvim", },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Fuzzy Finder Algorithm
    -- Project window
    { "ahmedkhalf/project.nvim", lazy = true },

    -- Git
    -- Fugitive, from the godfather of Vim
    { "tpope/vim-fugitive", event = "VeryLazy" },
    -- Superfast Git decorations
    { "lewis6991/gitsigns.nvim", event = "VeryLazy" },

    -- editorconfig
    { "gpanders/editorconfig.nvim" },
}
