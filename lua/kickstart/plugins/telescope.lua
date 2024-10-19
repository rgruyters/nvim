return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires special font.
      --  If you already have a Nerd Font, or terminal set up with fallback fonts
      --  you can enable this
      -- { 'nvim-tree/nvim-web-devicons' }
    },
    keys = function()
      --
      -- See `:help telescope.builtin`
      local builtin = require('telescope.builtin')

      local keys = {
        { '<leader>fh', builtin.help_tags, desc = '[S]earch [H]elp' },
        { '<leader>fk', builtin.keymaps, desc = '[S]earch [K]eymaps' },
        { '<leader>ff', builtin.find_files, desc = '[S]earch [F]iles' },
        { '<leader>fs', builtin.builtin, desc = '[S]earch [S]elect Telescope' },
        { '<leader>fw', builtin.grep_string, desc = '[S]earch current [W]ord' },
        { '<leader>fg', builtin.live_grep, desc = '[S]earch by [G]rep' },
        { '<leader>fd', builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
        { '<leader>fr', builtin.resume, desc = '[S]earch [R]esume' },
        { '<leader>f.', builtin.oldfiles, desc = '[S]earch Recent Files ("." for repeat)' },
        { '<leader><leader>', builtin.buffers, desc = '[ ] Find existing buffers' },
        { '<leader>gc', builtin.git_commits, desc = '[G]it [C]ommits' },
        { '<leader>/', builtin.current_buffer_fuzzy_find, desc = '[/] Fuzzy search current buffer' },
        { '<leader>gf', builtin.git_files, desc = '[G]it [F]iles' },
        { '<leader>gb', builtin.git_branches, desc = '[G]it [B]ranches' },
      }

      -- Slightly advanced example of overriding default behavior and theme
      table.insert(keys, {
        '<leader>/',
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = '[/] Fuzzily search in current buffer',
      })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      table.insert(keys, {
        '<leader>s/',
        function()
          builtin.live_grep({
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          })
        end,
        desc = '[S]earch [/] in Open Files',
      })

      -- Shortcut for searching your neovim configuration files
      table.insert(keys, {
        '<leader>sn',
        function()
          builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end,
        desc = '[S]earch [N]eovim files',
      })

      return keys
    end,
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of help_tags options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local actions = require('telescope.actions')

      require('telescope').setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        defaults = {
          mappings = {
            n = {
              --use 'd' to close buffers from bufexplorer
              ['d'] = require('telescope.actions').delete_buffer,
            },
            i = {
              ['<C-u>'] = actions.preview_scrolling_up,
              ['<C-d>'] = actions.preview_scrolling_down,
              ['<C-n>'] = actions.cycle_history_next,
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
  },
}
