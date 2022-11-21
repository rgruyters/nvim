local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local source_mapping = {
    buffer = "[BF]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[LUA]",
    cmp_tabnine = "[TN]",
    path = "[P]",
}

local icons = require "grtrs.icons"

-- local kind_icons = icons.kind
local lspkind = require("lspkind")

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", {fg ="#CA42F0"})

vim.g.cmp_active = true

cmp.setup({
    enabled = function()
        return vim.g.cmp_active
    end,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            vim_item.menu = source_mapping[entry.source.name]

            if entry.source.name == "cmp_tabnine" then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    vim_item.menu = entry.completion_item.data.detail .. " " .. vim_item.menu
                end

                vim_item.kind = icons.misc.Robot
                vim_item.kind_hl_group = "CmpItemKindTabnine"
            end

            if entry.source.name == "copilot" then
                vim_item.kind = icons.git.Octoface
                vim_item.kind_hl_group = "CmpItemKindCopilot"
            end

            return vim_item
        end,
    },
    sources = {
        { name = "buffer", keyword_length = 5 },
        { name = "copilot" },
        { name = "cmp_tabnine" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

-- Tabnine completion
local tabnine_status_ok, tabnine = pcall(require, "cmp_tabnine.config")
if not tabnine_status_ok then
    return
end

tabnine:setup {
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
    ignored_file_types = { -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
        mardown = true,
    },
}
