local diagnostic_icons = require('custom.icons').diagnostics

local signs = {
  { name = 'DiagnosticSignError', text = diagnostic_icons.Error },
  { name = 'DiagnosticSignWarn', text = diagnostic_icons.Warning },
  { name = 'DiagnosticSignHint', text = diagnostic_icons.Hint },
  { name = 'DiagnosticSignInfo', text = diagnostic_icons.Information },
}

-- define signs when diagnostics kicks in
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

-- bare minimum for diagnostics
local diagnostic_config = {
  virtual_text = true,
  signs = {
    active = signs, -- show signs
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

vim.diagnostic.config(diagnostic_config)

-- Add borders to diagnostics
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})
