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
  virtual_text = {
    spacing = 4,
    source = 'if_many',
    prefix = '●',
  },
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
  -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
  -- Be aware that you also will need to properly configure your LSP server to
  -- provide the inlay hints.
  inlay_hints = {
    enabled = true,
    exclude = { 'vue' }, -- filetypes for which you don't want to enable inlay hints
  },
  -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
  -- Be aware that you also will need to properly configure your LSP server to
  -- provide the code lenses.
  codelens = {
    enabled = false,
  },
  -- Enable lsp cursor word highlighting
  document_highlight = {
    enabled = true,
  },
  -- add any global capabilities here
  capabilities = {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
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
