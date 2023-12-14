return {
  'stevearc/conform.nvim',
  event = 'BufReadPre',
  dependencies = { 'mason.nvim' },
  cmd = 'ConformInfo',
  opts = {
    format = {
      timeout_ms = 3000,
      async = false,       -- not recommended to change
      quiet = false,       -- show notifications when available
      lsp_fallback = true, -- try using LSP formatting if no formatter is available
    },
    -- define options for formatter based on filetype ~ https://github.com/stevearc/conform.nvim#setup
    formatters_by_ft = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
    },
    -- options for custom formatters ~ https://github.com/stevearc/conform.nvim#customizing-formatters
    formatters = {
      injected = {
        options = { ignore_errors = true },
      },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
