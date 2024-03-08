-- Bring AI to Neovim with Github Copilot.
-- GitHub Copilot uses OpenAI Codex to suggest code and entire functions in
-- real-time right from your editor. Trained on billions of lines of public code,
-- GitHub Copilot turns natural language prompts including comments and method
-- names into coding suggestions across dozens of languages.
return {
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
      vim.keymap.set('n', '<leader>ct', '<CMD>Copilot toggle<CR>', { desc = 'Toggle Github Copilot', silent = true })
    end,
  },
  -- Update lualine to show copilot status
  {
    'nvim-lualine/lualine.nvim',
    optional = true,
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local icon = require('custom.icons').kind.Copilot
          local status = require('copilot.api').status.data
          return icon .. (status.message or '') .. ' '
        end,
        cond = function()
          local ok, clients = pcall(vim.lsp.get_clients, { name = 'copilot', bufnr = 0 })
          return ok and #clients > 0
        end,
        padding = { left = 1, right = 1 },
      })
    end,
  },
  -- use Github copilot as a completion source
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
    -- Add copilot as the first source
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = 'copilot',
        group_index = 1,
      })
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
