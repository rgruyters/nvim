return {
  -- Plugin: GitHub Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        lua = true,
      },
    },
    config = function(_, opts)
      require('copilot').setup(opts)
      vim.keymap.set('n', '<leader>gC', '<CMD>Copilot toggle<CR>', { desc = 'Toggle Github Copilot', silent = true })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    optional = true,
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local icon = require('custom.icons').kind.Copilot
          local status = require('copilot.api').status.data
          return icon .. (status.message or '')
        end,
        cond = function()
          local ok, clients = pcall(vim.lsp.get_active_clients, { name = 'copilot', bufnr = 0 })
          return ok and #clients > 0
        end,
        separator = '%#SLSeparator#' .. '' .. '%*',
      })
    end,
  },
  -- Plugin: GitHub Copilot completion integration
  {
    'nvim-cmp',
    event = { 'InsertEnter' },
    dependencies = {
      'zbirenbaum/copilot-cmp',
      dependencies = {
        'copilot.lua',
      },
      opts = {},
      config = function(_, opts)
        local copilot_cmp = require('copilot_cmp')
        copilot_cmp.setup(opts)
        -- attach cmp source whenever copilot attaches
        -- fixes lazy-loading issues with the copilot cmp source
        require('custom.functions').on_attach(function(client, _)
          if client.name == 'copilot' then
            copilot_cmp._on_insert_enter({})
          end
        end)
      end,
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = 'copilot',
        group_index = 1,
        priority = 100,
      })
      -- opts.sorting = opts.sorting or require('cmp.config.default')().sorting
      -- table.insert(opts.sorting.comparators, 1, require('copilot_cmp.comparators').prioritize)
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
