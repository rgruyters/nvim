return {
  "nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function(_, opts)
      local cmp = require("cmp")

      local cmp_sources = {
        { name = "nvim_lsp_signature_help" },
        { name = "buffer" },
        { name = "path" },
      }

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { cmp_sources }))
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
