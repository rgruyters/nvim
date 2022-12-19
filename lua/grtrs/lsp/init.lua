local lsp_zero_loaded, lsp = pcall(require, "lsp-zero")
if not lsp_zero_loaded then
    return
end

lsp.preset("recommended")

local servers = {
    "sumneko_lua",
    "cssls",
    "html",
    "tsserver",
    "pyright",
    "bashls",
    "jsonls",
    "yamlls",
    "terraformls",
    "tflint",
    "puppet",
    "ansiblels",
    "gopls",
}

local settings = {
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

lsp.ensure_installed(servers)

lsp.setup()

require("mason").setup(settings)

-- nvim-cmp supports additional completion capabilities
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
