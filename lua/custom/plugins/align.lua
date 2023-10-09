-- Plugin: Aligning lines
return {
  {
    'Vonr/align.nvim',
    branch = 'v2',
    keys = {
      -- Aligns to 1 character, looking left
      { 'aa', "<cmd>lua require('align').align_to_char(1, true)<CR>",           desc = 'Align 1 character', mode = {'v'} },
      -- Aligns to 2 characters, looking left and with previews
      { 'as', "<cmd>lua require('align').align_to_char(2, true, true)<CR>",     desc = 'Align 2 characters', mode = {'v'} },
      -- Aligns to a string, looking left and with previews
      { 'aw', "<cmd>lua require('align').align_to_char(false, true, true)<CR>", desc = 'Aligns to string', mode = {'v'} },
      -- Aligns to a Lua pattern, looking left and with previews
      { 'ar', "<cmd>lua require('align').align_to_char(true, true, true)<CR>",  desc = 'Align to Lua pattern', mode = {'v'} },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
