return {
    -- Plugin: Show colour codes
    {
        "NvChad/nvim-colorizer.lua",
        event = "VeryLazy",
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = false, -- "Name" codes like Blue oe blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes: foreground, background, virtualtext
                mode = "background", -- Set the display mode.)
            },
        }
    },
    -- Plugin: Alternative File Explorer
    {
        "tamago324/lir.nvim",
        event = { "BufEnter" },
        keys = {
            { "<leader>e", "<cmd>execute 'e ' .. expand('%:p:h')<CR>", desc = "Lir File Explorer"}
        },
        opts = function()
            local actions = require("lir.actions")
            local mark_actions = require("lir.mark.actions")
            local clipboard_actions = require("lir.clipboard.actions")

            return {
                show_hidden_files = true,
                ignore = {}, -- { ".DS_Store", "node_modules" } etc.
                devicons = {
                    enable = true,
                    highlight_dirname = false
                },
                mappings = {
                    ['l']     = actions.edit,
                    ['<CR>']  = actions.edit, -- use as fallback keymap

                    ['<C-s>'] = actions.split,
                    ['<C-v>'] = actions.vsplit,
                    ['<C-t>'] = actions.tabedit,

                    ['h']     = actions.up,
                    ['q']     = actions.quit,

                    ['d']     = actions.mkdir,
                    ['%']     = actions.newfile,
                    ['R']     = actions.rename,
                    ['@']     = actions.cd,
                    ['Y']     = actions.yank_path,
                    ['.']     = actions.toggle_show_hidden,
                    ['D']     = actions.delete,

                    ['J'] = function()
                        mark_actions.toggle_mark()
                        vim.cmd('normal! j')
                    end,
                    ['C'] = clipboard_actions.copy,
                    ['X'] = clipboard_actions.cut,
                    ['P'] = clipboard_actions.paste,
                },
                float = {
                    winblend = 0,
                    curdir_window = {
                        enable = false,
                        highlight_dirname = false
                    },
                },
                hide_cursor = true
            }
        end,
        config = function(_, opts)
            -- Disable netrw plugin when using Lir
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("lir").setup(opts)

            vim.api.nvim_create_autocmd({'FileType'}, {
                pattern = {"lir"},
                callback = function()
                    -- disable (relative) numbering
                    vim.opt_local.number = false
                    vim.opt_local.relativenumber = false

                    -- use visual mode
                    vim.api.nvim_buf_set_keymap(
                        0,
                        "x",
                        "J",
                        ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
                        { noremap = true, silent = true }
                    )

                    -- echo cwd
                    vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
                end
            })

            require("lir.git_status").setup {
                show_ignored = false,
            }

            -- custom folder icon
            require("nvim-web-devicons").set_icon({
                lir_folder_icon = {
                    icon = "",
                    color = "#7ebae4",
                    name = "LirFolderNode"
                }
            })

        end,
    },
    -- Plugin: Git status for Lir
    { "tamago324/lir-git-status.nvim", dependencies = "tamago324/lir.nvim" },
}
