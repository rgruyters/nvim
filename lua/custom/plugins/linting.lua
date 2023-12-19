return {
  'mfussenegger/nvim-lint',
  event = 'BufReadPre',
  opts = {
    linters_by_ft = {
      -- See nvim-lint repo for more information ~ https://github.com/mfussenegger/nvim-lint#usage
    },
  },
  config = function(_, opts)
      local lint = require('lint')

      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })

    vim.api.nvim_create_user_command("LinterInfo", function()
      local runningLinters = table.concat(require("lint").get_running(), "\n")
      vim.notify(runningLinters, vim.log.levels.INFO, { title = "nvim-lint" })
    end, {})
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
