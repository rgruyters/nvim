return {
  'rafamadriz/friendly-snippets',
  event = 'InsertEnter',
  dependencies = { 'L3MON4D3/LuaSnip' },
  config = function()
    local lsvs = require('luasnip.loaders.from_vscode')
    lsvs.lazy_load()
    lsvs.lazy_load({ paths = { './snippets' } })
  end,
}
