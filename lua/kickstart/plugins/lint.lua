return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    linters_by_ft = {
      -- See nvim-lint repo for more information ~ https://github.com/mfussenegger/nvim-lint#usage
    },
  },
  config = function(_, opts)
    local lint = require('lint')

    lint.linters_by_ft = opts.linters_by_ft

    -- Make sure the required linters are installed
    local function linting(ft)
      local linters = lint._resolve_linter_by_ft(ft)

      if linters then
        local registry_avail, registry = pcall(require, 'mason-registry')
        if not registry_avail then
          vim.api.nvim_err_writeln('Unable to access Mason registry')
          return false
        end

        -- Filter out linters that don't exist or needs to be installed before use
        linters = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          if not linter then
            vim.notify(string.format('Cannot find linter %s', linter), vim.log.levels.WARN, { title = 'nvim-lint' })
            return false
          end

          -- when Mason has the package in registry, check if the package is installed before use
          if registry.has_package(name) then
            local pkg = registry.get_package(name)
            if not pkg:is_installed() then
              vim.notify(string.format('Installing %s', name), vim.log.levels.INFO, { title = 'mason' })
              pkg:install()
              return false -- no point of running a linter during install
            end
          end
          return true
        end, linters)

        if #linters > 0 then
          lint.try_lint(linters)
        end
      end
      return false
    end

    -- create autocmd on events for firing nvim-lint
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
      callback = function()
        -- Do not execute linting on read-only buffers. This can get quite
        -- annoying when (e.g.) entering a LSP hover window.
        -- Besides that, there is no point for linting on read-only buffers.
        -- They cannot be updated.
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end,
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
