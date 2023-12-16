return {
  'nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'saadparwaiz1/cmp_luasnip',
  },
  opts = function(_, opts)
    table.insert(opts.sources, 1, {
      name = 'nvim_lsp_signature_help',
    })

    table.insert(opts.sources, 1, {
      name = 'buffer',
    })
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
