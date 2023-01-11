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

-- Disable default keybindings (optional)
lsp.set_preferences({
  set_lsp_keymaps = false
})

local cmp_loaded, cmp = pcall(require, "cmp")
if not cmp_loaded then
    return
end
local luasnip_loaded, luasnip = pcall(require, "luasnip")
if not luasnip_loaded then
    return
end

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end)
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(-1)
    end
end)

-- Update completion via lsp-zero
lsp.setup_nvim_cmp({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'luasnip' },
    }
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
