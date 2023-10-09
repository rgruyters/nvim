return {
  {
    'nvim-neotest/neotest',
    opts = {
      adapters = {},
    },
    keys = {
      { '<leader>tm', "<cmd>lua require('neotest').run.run()<cr>",
        { desc = 'Test Method' }
      },
      { '<leader>tM', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
        { desc = 'Test Method DAP' }
      },
      { '<leader>tf', "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
        { desc = 'Test Class' }
      },
      { '<leader>tF', "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
        { desc = 'Test Class DAP' }
      },
      { '<leader>tS', "<cmd>lua require('neotest').summary.toggle()<cr>",
        { desc = 'Test Summary' }
      },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
