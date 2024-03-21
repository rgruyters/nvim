-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})

-- Allow using q key to quit buffer for some filytypes
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'qf', 'help', 'man', 'netrw', 'lspinfo', 'fugitive', 'git' },
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = true })
    vim.opt_local.buflisted = false
  end,
})

-- Add project name to titlebar of terminal
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { '' },
  callback = function()
    local get_project_dir = function()
      local cwd = vim.fn.getcwd() or ''
      local project_dir = vim.split(cwd, '/')
      local project_name = project_dir[#project_dir]
      return project_name
    end

    vim.opt.titlestring = get_project_dir()
  end,
})

vim.api.nvim_create_user_command('Format', function()
  local conform_ok, conform = pcall(require, 'conform')
  if conform_ok then
    conform.format({ async = true, lsp_fallback = true })
  else
    vim.lsp.buf.format()
  end
end, { desc = 'Format current buffer' })

vim.api.nvim_create_user_command('InlayhintsToggle', function(_, bufnr)
  bufnr = bufnr or 0
  local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if inlay_hint.enable then
    vim.lsp.inlay_hint.enable(bufnr, not inlay_hint.is_enabled())
  else
    vim.lsp.inlay_hint(bufnr, nil)
  end
end, { desc = 'Toggle inlay hints' })

-- load the venv when a pyproject.toml is available
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Auto select virtualenv Nvim open',
  pattern = '*',
  callback = function()
    local venv = vim.fn.findfile('pyproject.toml', vim.fn.getcwd() .. ';')
    if venv ~= '' then
      local venv_okay, venv_selector = pcall(require, 'venv-selector')
      if venv_okay then
        venv_selector.retrieve_from_cache()
      end
    end
  end,
  once = true,
})
