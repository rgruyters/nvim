return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'markdown', 'markdown_inline' })
      end
    end,
  },
  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { 'markdownlint' },
      },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
