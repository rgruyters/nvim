local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
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

nmap('<leader>sf', require('telescope.builtin').find_files, '[S]earch [F]iles')
nmap('<leader>sh', require('telescope.builtin').help_tags, '[S]earch [H]elp')
nmap('<leader>sw', require('telescope.builtin').grep_string, '[S]earch current [W]ord')
nmap('<leader>sg', require('telescope.builtin').live_grep, '[S]earch by [G]rep')
nmap('<leader>sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')
nmap('<leader>sk', require('telescope.builtin').keymaps, '[S]earch [K]eymaps')

telescope.setup {
    defaults = {

        prompt_prefix = icons.ui.Telescope .. " ",
        selection_caret = " ",
        path_display = { "smart" },
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
    }
}
