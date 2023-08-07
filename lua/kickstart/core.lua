return {
  -- NOTE: First, some plugins that don't require any configuration
  -- Git related plugins
  {
    'tpope/vim-fugitive',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Git',
    init = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gp', function() vim.cmd.Git('push') end, { desc = '[G]it [p]ush' })
      vim.keymap.set('n', '<leader>gP', function() vim.cmd.Git('pull') end, { desc = 'Git [P]ull' })
    end,
  },
  {
    'tpope/vim-rhubarb',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    -- See `:help cmp`
    opts = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
      end

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        formatting = {
          format = function(_, item)
            local icons = require('custom.icons')

            if icons.kind[item.kind] then
              item.kind = icons.kind[item.kind] .. ' ' .. item.kind
            end

            return item
          end,
        },
        enabled = function()
          if require('cmp.config.context').in_treesitter_capture('comment') == true
              or require('cmp.config.context').in_syntax_group('Comment')
              or vim.bo.filetype == 'TelescopePrompt' then -- HACK: disable completion when using Telescope
            return false
          else
            return true
          end
        end,
      }
    end,
  },

  -- Snippets engine
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
      end,
    },
    keys = {
      {
        "<tab>",
        function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
      {
        "<C-j>",
        function()
          if require("luasnip").choice_active() then
            require("luasnip").change_choice(1)
          end
        end,
        mode = { "i", "s" }
      },
      {
        "<C-k>",
        function()
          if require("luasnip").choice_active() then
            require("luasnip").change_choice(-1)
          end
        end,
        mode = { "i", "s" }
      },
    },
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    opts = {
      defaults = {
        mode = { 'n', 'v' },
      },
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for keymaps that start with a native binding
        i = { "j", "k", "d" },
        v = { "j", "k" },
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        -- Navigation
        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Go to Previous Hunk' })

        vim.keymap.set('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Go to Next Hunk' })

        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    -- Nice pastel theme
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    -- See `:help lualine.txt`
    opts = function()
      M = {}
      local icons = require('custom.icons')

      local hide_in_width = function()
        return vim.o.columns > 80
      end

      local filename = {
        'filename',
        path = 1, -- display relative path
        shorting_target = 40,
      }

      -- show number of spaces that is used for current buffer
      local spaces = {
        function()
          return icons.misc.Spaces .. ' ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
        end,
        padding = 1,
        separator = '',
      }

      local lsp = {
        function(msg)
          msg = msg or "LS Inactive"
          local buf_clients = vim.lsp.get_active_clients()
          if next(buf_clients) == nil then
            if type(msg) == "boolean" or #msg == 0 then
              return "LS Inactive"
            end
            return msg
          end

          local buf_ft = vim.bo.filetype
          local buf_client_names = {}

          -- add client
          for _, client in pairs(buf_clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
              if client.name ~= "copilot" and client.name ~= "null-ls" then
                table.insert(buf_client_names, client.name)
              end
            end
          end

          -- add formatter
          local sources = require "null-ls.sources"
          local available_sources = sources.get_available(buf_ft)
          local registered = {}

          for _, source in ipairs(available_sources) do
            for method in pairs(source.methods) do
              registered[method] = registered[method] or {}
              table.insert(registered[method], source.name)
            end
          end

          local formatter = registered["NULL_LS_FORMATTING"]
          local linter = registered["NULL_LS_DIAGNOSTICS"]

          if formatter ~= nil then
            vim.list_extend(buf_client_names, formatter)
          end

          if linter ~= nil then
            vim.list_extend(buf_client_names, linter)
          end

          -- join client names with commas
          local client_names_str = table.concat(buf_client_names, ", ")

          -- check client_names_str if empty
          local language_servers = ""

          if #client_names_str ~= 0 then
            language_servers = "%#SLLSP#" .. "[" .. client_names_str .. "]" .. "%*"
          end

          if #client_names_str == 0 then
            return ""
          else
            M.language_servers = language_servers
            return language_servers
          end
        end,
        padding = 0,
        separator = "%#SLSeparator#" .. " " .. "%*",
        cond = hide_in_width,
      }

      -- Change text color for lanuage_server output
      vim.api.nvim_set_hl(0, "SLLSP", { fg = "#616E88", bg = "#1E1E2E" })

      return {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { filename },
          lualine_x = { lsp, spaces, 'filetype' },
          lualine_y = { 'location' },
          lualine_z = { 'progress' }
        },
        extensions = { 'fugitive', 'lazy', 'nvim-dap-ui', 'trouble' },
      }
    end,
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    event = { 'BufReadPost', 'BufNewFile' },
    -- See `:help indent_blankline.txt`
    opts = {
      char = '▏',
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
  },

  -- 'gc' to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- See `:help telescope.builtin`
    keys = {
      {'<leader>?', function() require('telescope.builtin').oldfiles() end, desc = '[?] Find recently opened files' },
      {'<leader><space>', function() require('telescope.builtin').buffers() end, desc = '[ ] Find existing buffers' },
      {'<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, desc = '[/] Fuzzily search in current buffer' },
      {'<leader>gf', function() require('telescope.builtin').git_files() end, desc = 'Search [G]it [F]iles' },
      {'<leader>sf', function() require('telescope.builtin').find_files() end, desc = '[S]earch [F]iles' },
      {'<leader>sh', function() require('telescope.builtin').help_tags() end, desc = '[S]earch [H]elp' },
      {'<leader>sw', function() require('telescope.builtin').grep_string() end, desc = '[S]earch current [W]ord' },
      {'<leader>sg', function() require('telescope.builtin').live_grep() end, desc = '[S]earch by [G]rep' },
      {'<leader>sd', function() require('telescope.builtin').diagnostics() end, desc = '[S]earch [D]iagnostics' },
    },
    opts = function()
      local actions = require('telescope.actions')

      return {
        -- See `:help telescope` and `:help telescope.setup()`
        defaults = {
          prompt_prefix = require('custom.icons').misc.Telescope .. ' ',
          selection_caret = ' ',
          path_display = { 'smart' },
          color_devicons = true,
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
            },
          },
          pickers = {
            find_files = {
              hidden = true,
              theme = 'dropdown',
            }
          },
          git_files = {
            hidden = true,
            show_untracked = true,
          },
          file_ignore_patterns = {
            '.git/',
            'target/',
            'vendor/*',
            '%.lock',
            '__pycache__/*',
            '%.sqlite3',
            '%.ipynb',
            'node_modules/*',
            '%.jpg',
            '%.jpeg',
            '%.png',
            '%.svg',
            '%.otf',
            '%.ttf',
            '%.webp',
            '.dart_tool/',
            '.github/',
            '.gradle/',
            '.idea/',
            '.settings/',
            '.vscode/',
            '__pycache__/',
            'build/',
            'env/',
            'gradle/',
            'node_modules/',
            '%.pdb',
            '%.dll',
            '%.class',
            '%.exe',
            '%.cache',
            '%.ico',
            '%.pdf',
            '%.dylib',
            '%.jar',
            '%.docx',
            '%.met',
            'smalljre_*/*',
            '.vale/',
            '%.burp',
            '%.mp4',
            '%.mkv',
            '%.rar',
            '%.zip',
            '%.7z',
            '%.tar',
            '%.bz2',
            '%.epub',
            '%.flac',
            '%.tar.gz',
          },
        },
      }
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    event = 'VeryLazy',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    -- See `:help nvim-treesitter`
    opts = {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        'go',
        'lua',
        'python',
        'rust',
        'tsx',
        'typescript',
        'vimdoc',
        'vim',
        'hcl',
        'terraform',
        'markdown',
        'markdown_inline'
      },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      require('nvim-treesitter.install').prefer_git = true
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
