local lsp_zero_loaded, lsp = pcall(require, "lsp-zero")
if not lsp_zero_loaded then
    return
end

lsp.preset("recommended")

local servers = {
    "sumneko_lua",
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

-- install preferred LSP servers
lsp.ensure_installed(servers)

-- Update completion via lsp-zero
lsp.setup_nvim_cmp({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path', keyword_length = 3 },
    },
})

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

    lsp.configure(server, opts)
end

lsp.setup()

require("mason").setup(settings)

require("grtrs.lsp.handlers").setup()
require("grtrs.lsp.null-ls")
