-- AI-powered coding
return {
  {
    'olimorris/codecompanion.nvim',
    cmd = { 'CodeCompanion', 'CodeCompanionActions', 'CodeCompanionChat' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
      'nvim-telescope/telescope.nvim', -- Optional: For using slash commands
    },
    keys = {
      { '<C-a>', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' } },
      { '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>' },
    },
    opts = {
      strategies = {
        chat = {
          adapter = 'ollama',
        },
        inline = {
          adapter = 'ollama',
        },
      },
      adapters = {
        llama3 = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'deepseek-coder', -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = 'deepseek-coder-v2:latest',
              },
            },
          })
        end,
      },
    },
    config = function(_, opts)
      require('codecompanion').setup(opts)
    end,
  },
}
