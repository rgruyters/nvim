return {
  -- Plugin: for formatters and linters
  {
    'nvimtools/none-ls.nvim',
    event = 'LspAttach',
    opts = function()
      local nonels = require('null-ls')

      return {
        sources = {
          nonels.builtins.formatting.prettier.with {
            extra_filetypes = { 'toml', 'markdown' },
            extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
          },
          nonels.builtins.formatting.shfmt,
          nonels.builtins.formatting.stylua,
          nonels.builtins.diagnostics.markdownlint,
        },
      }
    end
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
