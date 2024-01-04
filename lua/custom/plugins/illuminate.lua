-- Plugin: Highlight words
return {
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 200,
      filetypes_denylist = {
        'fugitive',
        'netrw',
        'TelescopePrompt',
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      -- disables illuminate on very large files as it slowd down the editor
      vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
        callback = function()
          local line_count = vim.api.nvim_buf_line_count(0)
          if line_count >= 5000 then
            vim.cmd('IlluminatePauseBuf')
          end
        end,
      })
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
