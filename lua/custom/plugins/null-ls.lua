return {
  -- Plugin: for formatters and linters
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local null_ls = require("null-ls")

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      local formatting = null_ls.builtins.formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      local diagnostics = null_ls.builtins.diagnostics

      return {
        sources = {
          formatting.prettier.with {
            extra_filetypes = { "toml", "markdown" },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
          },
          formatting.black.with { extra_args = { "--fast" } },
          formatting.shfmt,
          formatting.puppet_lint,
          formatting.terrafmt,
          formatting.gofmt,
          diagnostics.markdownlint,
          diagnostics.ansiblelint,
        },
      }
    end
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
