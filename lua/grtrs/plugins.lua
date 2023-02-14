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
    -- Undotree
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
        },
    },

    -- Close buffers by keeping layout
    { "moll/vim-bbye" },
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

    -- Show colour codes
    { "NvChad/nvim-colorizer.lua", lazy = true },

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = true,
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
            'rafamadriz/friendly-snippets',
        },
    },
    -- for formatters and linters
    { "jose-elias-alvarez/null-ls.nvim", lazy = true },
    -- Highlight words
    { "RRethy/vim-illuminate", lazy = true },
    -- VSCode icons
    { "onsails/lspkind-nvim", lazy = true },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context" -- Show context
        },
        build = ":TSUpdate"
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Fuzzy Finder Algorithm
        },
        lazy = true,
    },
    -- Project window
    { "ahmedkhalf/project.nvim", lazy = true },

    {
        "cshuaimin/ssr.nvim",
        -- init is always executed during startup, but doesn't load the plugin yet.
        init = function()
            vim.keymap.set({ "n", "x" }, "<leader>cR", function()
                -- this require will automatically load the plugin
                require("ssr").open()
            end, { desc = "Structural Replace" })
        end,
    },

    -- Buffer management
    { "ThePrimeagen/harpoon", lazy = true },

    -- Git
    -- Fugitive, from the godfather of Vim
    { "tpope/vim-fugitive", event = "VeryLazy" },
    -- Superfast Git decorations
    { "lewis6991/gitsigns.nvim", event = "VeryLazy" },
    -- Nice diffviewer
    { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },
    -- View Git messages in a window
    { "rhysd/git-messenger.vim" },
    -- Lazygit for Neovim
    {
        "kdheepak/lazygit.nvim",
        keys = {
            { "<leader>lg", "<cmd>LazyGit<CR>", desc = "[L]azy [G]it" },
        },
    },

    -- editorconfig
    { "gpanders/editorconfig.nvim" },

    -- DAP
    { "mfussenegger/nvim-dap", lazy = true },
    { "mfussenegger/nvim-dap-python", lazy = true },
    { "rcarriga/nvim-dap-ui", lazy = true },
    { "theHamsta/nvim-dap-virtual-text", lazy = true },
    {
        "nvim-telescope/telescope-dap.nvim",
        config = function()
            require('telescope').load_extension('dap')
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-nvim-dap").setup({ automatic_setup = true })
        end
    },

    -- Markdown Previewer
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
}
