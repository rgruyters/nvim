vim.cmd('set tw=80 wrap linebreak')

vim.keymap.set(
  'i',
  'dts',
  '<C-R>=strftime("%FT%T+1")<CR>',
  { silent = true, desc = 'Insert current [d]ate[t]ime [s]tring' }
)
