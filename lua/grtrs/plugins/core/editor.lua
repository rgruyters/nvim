return {
    -- Plugin: Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
        opts = {
            ensure_installed = {
                "help",
                "hcl",
                "bash",
                "python",
                "markdown",
                "markdown_inline",
                "dockerfile",
                "json",
                "lua",
                "vim",
                "yaml",
                "go",
                "terraform",
            },                       -- one of "all" or a list of languages
            ignore_install = { "" }, -- List of parsers to ignore installing
            matchup = {
                enable = true,       -- mandatory, false will disable the whole extension
            },
            highlight = {
                enable = true, -- false will disable the whole extension
            },
            autopairs = {
                enable = true,
            },
            indent = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    -- Plugin: Treesitter Context
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
            throttle = true, -- Throttles plugin updates (may improve performance)
            max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        },
    },
    -- Plugin: Telescope
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = "*",
        dependencies = "nvim-lua/plenary.nvim",
        keys = {
            { "<leader>?",       "<cmd>Telescope old_files<CR>",                desc = "[?] Find recently opened files" },
            { "<leader>ff",      "<cmd>Telescope find_files<CR>",               desc = "[F]ind [F]iles" },
            { "<leader><space>", "<cmd>Telescope buffers<CR>",                  desc = "[ ] Find existing buffers" },
            { "<leader>fh",      "<cmd>Telescope help_tags<CR>",                desc = "[F]ind [H]elp" },
            { "<leader>fw",      "<cmd>Telescope grep_string<CR>",              desc = "[F]ind current [W]ord" },
            { "<leader>fg",      "<cmd>Telescope live_grep<CR>",                desc = "[F]ind by [G]rep" },
            { "<leader>fd",      "<cmd>Telescope lsp_document_diagnostics<CR>", desc = "[F]ind [D]iagnostics" },
            { "<leader>fk",      "<cmd>Telescope keymaps<CR>",                  desc = "[F]ind [K]eymaps" },
            { "<leader>go",      "<cmd>Telescope git_status<CR>",               desc = "[G]it [O]pen changed files" },
            { "<leader>gb",      "<cmd>Telescope git_branches<CR>",             desc = "[G]it [B]ranches" },
            { "<leader>gc",      "<cmd>Telescope git_commits<CR>",              desc = "[G]it [C]ommits" },
        },
        opts = function()
            local actions = require "telescope.actions"
            local icons = require "grtrs.icons"

            return {
                defaults = {
                    prompt_prefix = icons.ui.Telescope .. " ",
                    selection_caret = " ",
                    path_display = { "smart" },
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" },
                    file_ignore_patterns = {
                        ".git/",
                        "target/",
                        "vendor/*",
                        "%.lock",
                        "__pycache__/*",
                        "%.sqlite3",
                        "%.ipynb",
                        "node_modules/*",
                        "%.jpg",
                        "%.jpeg",
                        "%.png",
                        "%.svg",
                        "%.otf",
                        "%.ttf",
                        "%.webp",
                        ".dart_tool/",
                        ".github/",
                        ".gradle/",
                        ".idea/",
                        ".settings/",
                        ".vscode/",
                        "__pycache__/",
                        "build/",
                        "env/",
                        "gradle/",
                        "node_modules/",
                        "%.pdb",
                        "%.dll",
                        "%.class",
                        "%.exe",
                        "%.cache",
                        "%.ico",
                        "%.pdf",
                        "%.dylib",
                        "%.jar",
                        "%.docx",
                        "%.met",
                        "smalljre_*/*",
                        ".vale/",
                        "%.burp",
                        "%.mp4",
                        "%.mkv",
                        "%.rar",
                        "%.zip",
                        "%.7z",
                        "%.tar",
                        "%.bz2",
                        "%.epub",
                        "%.flac",
                        "%.tar.gz",
                    },
                    mappings = {
                        i = {
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                        n = {
                            ["<esc>"] = actions.close,
                            ["<CR>"] = actions.select_default,
                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                            ["H"] = actions.move_to_top,
                            ["M"] = actions.move_to_middle,
                            ["L"] = actions.move_to_bottom,
                            ["gg"] = actions.move_to_top,
                            ["G"] = actions.move_to_bottom,
                        }
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        theme = "dropdown",
                    }
                },
                git_files = {
                    hidden = true,
                    show_untracked = true,
                },
                colorscheme = {
                    enable_preview = true,
                }
            }
        end,
        config = function(_, opts)
            require("telescope").setup(opts)
        end,
    },
    -- Plugin: Telescope Fuzzy Finder Algorithm
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        dependencies = "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    -- Plugin: Project window
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "[F]ind [P]rojects" },
        },
        opts = {
            active = true,
            on_config_done = nil,
            manual_mode = false,
            -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
            detection_methods = { "pattern" },
            patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
            show_hidden = true,
            silent_chdir = true,
            ignore_lsp = {},
            datapath = vim.fn.stdpath("data"),
        },
        config = function(_, opts)
            require("project_nvim").setup(opts)
            require("telescope").load_extension('projects')
        end,
    },
    -- Plugin: Make comments pretty
    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
        opts = function()
            local commentstring_avail, commentstring = pcall(require,
                "ts_context_commentstring.integrations.comment_nvim")
            return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
        end,
    },
    -- Plugin: Aligning lines
    {
        "Vonr/align.nvim",
        lazy = true,
        keys = {
            { "aa", "<cmd>lua require('align').align_to_char(1, true)<CR>",           desc = "Align 1 character" },    -- Aligns to 1 character, looking left
            { "as", "<cmd>lua require('align').align_to_char(2, true, true)<CR>",     desc = "Align 2 characters" },   -- Aligns to 2 characters, looking left and with previews
            { "aw", "<cmd>lua require('align').align_to_char(false, true, true)<CR>", desc = "Aligns to string" },     -- Aligns to a string, looking left and with previews
            { "ar", "<cmd>lua require('align').align_to_char(true, true, true)<CR>",  desc = "Align to Lua pattern" }, -- Aligns to a Lua pattern, looking left and with previews
        },
    },
    -- Plugin: Autopair
    { "windwp/nvim-autopairs" },
    -- Plugin: highlight todo comments
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
        opts = {
            highlight = {
                before = "",                     -- "fg" or "bg" or empty
                keyword = "wide_fg",             -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty
                after = "fg",                    -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                comments_only = true,            -- uses treesitter to match keywords in comments only
                max_line_len = 400,              -- ignore lines longer than this
                exclude = {},                    -- list of file types to exclude highlighting
            },
        },
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>ft", "<cmd>TodoTelescope keywords=TODO,FIX,HACK<CR>",     desc = "Telescope: [F]ind [T]odo" }
        },
    },
    -- Plugin: Surround selections
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = true,
        event = "VeryLazy"
    },
    -- Plugin: editorconfig
    -- NOTE: this plugin will be obsolete with Neovim version 0.9
    { "gpanders/editorconfig.nvim" },
}
