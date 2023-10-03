return {
  'windwp/nvim-autopairs',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'hrsh7th/nvim-cmp' },
  opts = {
    check_ts = true, -- treesitter integration
    disable_filetype = { 'TelescopePrompt' },
  },
  config = function()
    require('nvim-autopairs').setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
