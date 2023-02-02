local telescope_loaded, telescope = pcall(require, "telescope")
if not telescope_loaded then
    return
end

local actions = require "telescope.actions"
local icons = require "grtrs.icons"

-- Telescope
-- See `:help telescope.builtin`
local nmap = function(keys, func, desc)
    if desc then
        desc = 'Telescope: ' .. desc
    end

    vim.keymap.set('n', keys, func, { silent = true, desc = desc })
end

nmap('<leader>?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
nmap('<leader><space>', require('telescope.builtin').buffers, '[ ] Find existing buffers')

nmap('<leader>ff', require('telescope.builtin').find_files, '[F]ind [F]iles')
nmap('<leader>fh', require('telescope.builtin').help_tags, '[F]ind [H]elp')
nmap('<leader>fw', require('telescope.builtin').grep_string, '[F]ind current [W]ord')
nmap('<leader>fg', require('telescope.builtin').live_grep, '[F]ind by [G]rep')
nmap('<leader>fd', require('telescope.builtin').diagnostics, '[F]ind [D]iagnostics')
nmap('<leader>fk', require('telescope.builtin').keymaps, '[F]ind [K]eymaps')

-- Git related
nmap('<leader>go', require('telescope.builtin').git_status, '[G]it [O]pen changed files')
nmap('<leader>gb', require('telescope.builtin').git_branches, '[G]it [B]ranches')
nmap('<leader>gc', require('telescope.builtin').git_commits, '[G]it [C]ommits')

telescope.setup {
    defaults = {

        prompt_prefix = icons.ui.Telescope .. " ",
        selection_caret = " ",
        path_display = { "smart" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_ignore_patterns = {
            ".git/",
            "target/",
            "docs/",
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

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
