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
          adapter = 'anthropic',
        },
        inline = {
          adapter = 'anthropic',
        },
      },
    },
    config = function(_, opts)
      require('codecompanion').setup(opts)
    end,
  },
}
