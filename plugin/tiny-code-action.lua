vim.api.nvim_create_autocmd('LspAttach', {
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/rachartier/tiny-code-action.nvim' })

    vim.keymap.set({ 'n', 'x' }, '<leader>ca', function()
      require('tiny-code-action').code_action()
    end, { noremap = true, silent = true })
  end,
})
