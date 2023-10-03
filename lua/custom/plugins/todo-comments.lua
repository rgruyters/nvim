-- Plugin: highlight todo comments
return {
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    config = true,
    keys = {
      { ']t',         function() require('todo-comments').jump_next() end, desc = 'Next todo comment' },
      { '[t',         function() require('todo-comments').jump_prev() end, desc = 'Previous todo comment' },
      { '<leader>xt', '<cmd>TodoTrouble<cr>',                              desc = 'Todo (Trouble)' },
      { '<leader>ft', '<cmd>TodoTelescope keywords=TODO,FIX,HACK<CR>',     desc = 'Telescope: [F]ind [T]odo' }
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
