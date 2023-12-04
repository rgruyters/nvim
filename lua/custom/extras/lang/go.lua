return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'go',
      })
    end,
  },
  -- Ensure Go tools are installed
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'goimports', 'gofumpt' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
            },
          },
          flags = {
            debounce_text_changes = 150,
          },
        },
      },
    },
  },
  {
    'nvimtools/none-ls.nvim',
    optional = true,
    opts = function(_, opts)
      if type(opts.sources) == 'table' then
        local nonels = require('null-ls')
        vim.list_extend(opts.sources, {
          nonels.builtins.formatting.gofmt,
        })
      end
    end,
  },
  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = {
      'nvim-neotest/neotest-go',
    },
    opts = {
      adapters = {
        ['neotest-go'] = {},
      },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
