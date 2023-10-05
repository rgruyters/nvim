vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'terraform-vars' },
  desc = 'set correct filetype for terraform vars',
  command = 'set ft=terraform',
})

return {
    {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'hcl',
        'terraform',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        terraformls = {
          filetypes = {
            'terraform',
            'tf',
          },
        },
      },
    },
  },
  {
    'nvimtools/none-ls.nvim',
    optional = true,
    opts = function(_, opts)
      if type(opts.sources) == 'table' then
        local nonels = require('null-ls')
        vim.list_extend(opts.sources, {
          nonels.builtins.formatting.terrafmt,
        })
      end
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
