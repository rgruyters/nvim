return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
    event = 'InsertEnter',
    config = function()
      local lsvs = require('luasnip.loaders.from_vscode')
      lsvs.lazy_load()
      lsvs.lazy_load({ paths = { './snippets' } })
    end,
  },
}
