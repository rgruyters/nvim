return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'python',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = false,
              typeCheckingMode = 'standard',
            },
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                typeCheckingMode = 'basic',
                diagnosticMode = 'workspace',
                useLibraryCodeForTypes = true,
                inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                },
              },
            },
          },
        },
        ruff_lsp = {},
      },
    },
    setup = {
      ruff_lsp = function()
        require('custom.functions').on_attach(function(client, _)
          if client.name == 'ruff_lsp' then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    },
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'black')
    end,
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        ['python'] = { 'black' },
      },
    },
  },
  {
    -- use own debugging language
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'python',
    config = function()
      local dap_python = require('dap-python')
      local mason_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/')

      dap_python.setup(mason_path .. 'packages/debugpy/venv/bin/python')

      dap_python.test_runner = 'pytest'
    end,
  },
  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = {
      'nvim-neotest/neotest-python',
    },
    opts = {
      adapters = {
        ['neotest-python'] = {},
      },
    },
  },
  {
    'linux-cultist/venv-selector.nvim',
    cmd = 'VenvSelect',
    opts = {
      dap_enabled = true,
      name = {
        'venv',
        '.venv',
      },
    },
    keys = { { '<leader>cv', '<cmd>:VenvSelect<cr>', desc = 'Select VirtualEnv' } },
  },
  -- HACK: correct highlights for variables and classes
  {
    'rose-pine',
    name = 'rose-pine',
    optional = true,
    opts = function(_, opts)
      local highlight_groups = vim.tbl_deep_extend('force', opts.highlight_groups or {}, {
        ['@lsp.type.variable'] = {},
        ['@lsp.type.namespace.python'] = { link = '@variable' },
      })
      opts.highlight_groups = highlight_groups
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
