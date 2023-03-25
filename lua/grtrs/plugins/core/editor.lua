return {
    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", dependencies = "nvim-treesitter/nvim-treesitter-context", build = ":TSUpdate" },
    -- Telescope
    { "nvim-telescope/telescope.nvim", version = "*", dependencies = "nvim-lua/plenary.nvim", },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Fuzzy Finder Algorithm
    -- Project window
    { "ahmedkhalf/project.nvim", lazy = true },
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
    -- highlight todo comments
    { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", lazy = true },
    -- Surround selections
    { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
    -- editorconfig
    { "gpanders/editorconfig.nvim" },
}
