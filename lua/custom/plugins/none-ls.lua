return {
  -- Plugin: for formatters and linters
  {
    'nvimtools/none-ls.nvim',
    event = 'LspAttach',
    opts = function(_, opts)
      local nls = require('null-ls')
      opts.root_dir = opts.root_dir
        or require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git')
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.diagnostics.markdownlint,
      })
    end,
  },
  -- Load required formatters and linters
  {
    'mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'stylua', 'shfmt', 'markdownlint-cli2' })
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
