return {
  {
    'moll/vim-bbye',
    event = { "BufReadPre", "BufNewFile" },
    cmd = 'Bdelete',
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
