return {
  -- Git related plugins
  {
    -- See `:help Git`
    'tpope/vim-fugitive',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Git',
    init = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gp', function()
        vim.cmd.Git('push')
      end, { desc = '[G]it [p]ush' })
      vim.keymap.set('n', '<leader>gP', function()
        vim.cmd.Git('pull')
      end, { desc = 'Git [P]ull' })
    end,
  },
  {
    -- See `:h rhubarb.txt`
    'tpope/vim-rhubarb',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    -- See `:help cmp`
    opts = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete({}),
          ['<CR>'] = cmp.mapping.confirm({
            select = true,
          }),
          ['<S-CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
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
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }),
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
          -- Disable completion in comments and Telescope
          if
            require('cmp.config.context').in_treesitter_capture('comment') == true
            or require('cmp.config.context').in_syntax_group('Comment')
            or vim.bo.filetype == 'TelescopePrompt' -- HACK: disable completion when using Telescope
          then
            return false
          else
            return true
          end
        end,
      }
    end,
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require('cmp').setup(opts)
    end,
  },

  -- Snippets engine
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets',
      event = 'InsertEnter',
      config = function()
        local lsvs = require('luasnip.loaders.from_vscode')
        lsvs.lazy_load()
        lsvs.lazy_load({ paths = { './snippets' } })
      end,
    },
    config = function()
      local ls = require('luasnip')

      ls.setup() -- setup luasnip with default settings

      vim.keymap.set({ 'i', 's' }, '<C-j>', function() if ls.choice_active() then ls.change_choice(1) end end)
      vim.keymap.set({ 'i', 's' }, '<C-k>', function() if ls.choice_active() then ls.change_choice(-1) end end)
    end,
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      defaults = {
        mode = { 'n', 'v' },
      },
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for keymaps that start with a native binding
        i = { 'j', 'k', 'd' },
        v = { 'j', 'k' },
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
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })

        vim.keymap.set('n', '<leader>hs', require('gitsigns').stage_hunk, { buffer = bufnr, desc = 'Stage Hunk' })
        vim.keymap.set('n', '<leader>hr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = 'Reset Hunk' })
        vim.keymap.set('n', '<leader>hS', require('gitsigns').stage_buffer, { buffer = bufnr, desc = 'Stage Buffer' })
        vim.keymap.set(
          'n',
          '<leader>hu',
          require('gitsigns').undo_stage_hunk,
          { buffer = bufnr, desc = 'Undo Stage Hunk' }
        )
        vim.keymap.set('n', '<leader>hR', require('gitsigns').reset_buffer, { buffer = bufnr, desc = 'Reset Buffer' })
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' })
        vim.keymap.set('n', '<leader>hb', require('gitsigns').blame_line, { buffer = bufnr, desc = 'Blame Line' })
        vim.keymap.set(
          'n',
          '<leader>tb',
          require('gitsigns').toggle_current_line_blame,
          { buffer = bufnr, desc = 'Toggle Line Blame' }
        )
        vim.keymap.set('n', '<leader>hd', require('gitsigns').diffthis, { buffer = bufnr, desc = 'Diff This' })
        vim.keymap.set('n', '<leader>td', require('gitsigns').blame_line, { buffer = bufnr, desc = 'Toggle Deleted' })
      end,
    },
  },

  {
    -- Nice pastel theme
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    -- See `:help lualine.txt`
    opts = function()
      local icons = require('custom.icons')

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
      }

      return {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '|', right = '' },
          section_separators = '',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { filename },
          lualine_x = { spaces, 'filetype' },
          lualine_y = { 'location' },
          lualine_z = { 'progress' },
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
    main = 'ibl',
    -- See `:help indent_blankline.txt`
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = {
        show_start = false,
        show_end = false,
      },
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
    opts = function()
      local actions = require('telescope.actions')

      return {
        -- See `:help telescope` and `:help telescope.setup()`
        defaults = require('telescope.themes').get_dropdown({
          prompt_prefix = require('custom.icons').misc.Telescope .. ' ',
          selection_caret = ' ',
          path_display = { 'smart' },
          color_devicons = true,
          mappings = {
            i = {
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
            },
          },
          file_ignore_patterns = {
            '.git/',
            '__pycache__/',
            'node_modules/',
            '.github/',
            'build/',
            'env/',
          },
        }),
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        git_files = {
          hidden = true,
          show_untracked = true,
        },
      }
    end,
    config = function(_, opts)
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [C]ommits' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })

      require('telescope').setup(opts)
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
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
        'lua',
        'vimdoc',
        'vim',
        'markdown',
        'markdown_inline',
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
      vim.defer_fn(function()
        require('nvim-treesitter.configs').setup(opts)
        require('nvim-treesitter.install').prefer_git = true
      end, 0)
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
