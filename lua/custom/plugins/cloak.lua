return {
  'laytan/cloak.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function(_, opts)
    local cloak = require('cloak')
    cloak.setup(opts)
  end,
}
