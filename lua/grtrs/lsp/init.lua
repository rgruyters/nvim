local mason_loaded, mason = pcall(require, "mason")
if not mason_loaded then
    return
end

local mason_lsp_loaded, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_loaded then
    return
end

-- Setup Mason package manager
mason.setup({
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})

-- Setup Mason LSP
mason_lspconfig.setup({
    ensure_installed = {},
    automatic_installation = true,
})

-- LSP setup handler for setting each language server
-- Load the custom settings file when available and merge/extend it with default opts
mason_lspconfig.setup_handlers {
    function(server)
        local opts = {
            on_attach = require("grtrs.lsp.handlers").on_attach,
            capabilities = require("grtrs.lsp.handlers").capabilities,
        }

        local conf_opts_loaded, conf_opts = pcall(require, "grtrs.lsp.settings." .. server)
        if conf_opts_loaded then
            opts = vim.tbl_deep_extend("force", conf_opts, opts)
        end

        require("lspconfig")[server].setup(opts)
    end
}

require("grtrs.lsp.handlers").setup()
require("grtrs.lsp.null-ls")
