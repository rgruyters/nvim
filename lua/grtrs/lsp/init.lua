local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("grtrs.lsp.mason")
require("grtrs.lsp.handlers").setup()
require "grtrs.lsp.null-ls"
