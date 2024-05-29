return vim.fn.has('nvim-0.10') == 1
    and {
      'nvim-cmp',
      dependencies = {
        'garymjr/nvim-snippets',
        opts = {
          friendly_snippets = true,
        },
        dependencies = {
          'rafamadriz/friendly-snippets',
          event = 'InsertEnter',
          config = function()
            local snippets = require('luasnip.loaders.from_vscode')
            snippets.lazy_load()
            snippets.lazy_load({ paths = { './snippets' } })
          end,
        },
      },
      opts = function(_, opts)
        table.insert(opts.sources, { name = 'snippets' })
      end,
    }
  or {
    -- Add a bunch of pre-configured snippets. Custom snippets can be added to
    -- the `snippets/` folder in the root of the project.
    'L3MON4D3/LuaSnip',
    event = { 'InsertEnter' },
    dependencies = {
      'rafamadriz/friendly-snippets',
      event = 'InsertEnter',
      config = function()
        local snippets = require('luasnip.loaders.from_vscode')
        snippets.lazy_load()
        snippets.lazy_load({ paths = { './snippets' } })
      end,
    },
    enabled = vim.fn.has('nvim-0.10') == 0,
  }
