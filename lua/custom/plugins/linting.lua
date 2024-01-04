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

    local M = {}

    lint.linters_by_ft = opts.linters_by_ft

    function M.debounce(ms, fn)
      local timer = vim.loop.new_timer()
      return function(...)
        local argv = { ... }
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    function M.lint()
      -- Use nvim-lint's logic first:
      -- * checks if linters exist for the full filetype first
      -- * otherwise will split filetype by "." and add all those linters
      -- * this differs from conform.nvim which only uses the first filetype that has a formatter
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)

      -- Add global linters.
      vim.list_extend(names, lint.linters_by_ft['*'] or {})

      -- Filter out linters that don't exist or don't match the condition.
      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then
          vim.notify('Linter not found: ' .. name, vim.log.levels.INFO, { title = 'nvim-lint' })
          return false
        end
        return true
      end, names)

      -- Run linters.
      if #names > 0 then
        lint.try_lint(names)
      end
    end

    -- create autocmd on events for firing nvim-lint
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
      callback = M.debounce(100, M.lint),
    })

    -- add LinterInfo to display active linters
  vim.api.nvim_create_user_command('LinterInfo', function()
      local runningLinters = table.concat(require('lint').linters_by_ft[vim.bo.filetype] or {}, '\n')
      vim.notify(runningLinters, vim.log.levels.INFO, { title = 'nvim-lint' })
    end, {})

    -- add LinterRunning to show active running linters
    vim.api.nvim_create_user_command('LinterRunning', function()
      local runningLinters = table.concat(require('lint').get_running() or {}, '\n')
      vim.notify(runningLinters, vim.log.levels.INFO, { title = 'nvim-lint' })
    end, {})
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
