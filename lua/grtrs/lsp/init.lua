local mason_loaded, mason = pcall(require, "mason")
if not mason_loaded then
    return
end

local mason_lsp_loaded, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_loaded then
    return
end

local servers = {
    "lua_ls",
    "pyright",
    "bashls",
    "jsonls",
    "yamlls",
    "terraformls",
    "tflint",
}

local settings = {
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

mason.setup(settings)

mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local lspconfig_loaded, lspconfig = pcall(require, "lspconfig")
if not lspconfig_loaded then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("grtrs.lsp.handlers").on_attach,
        capabilities = require("grtrs.lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1]

    local conf_opts_loaded, conf_opts = pcall(require, "grtrs.lsp.settings." .. server)
    if conf_opts_loaded then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end

require("grtrs.lsp.handlers").setup()
require("grtrs.lsp.null-ls")
