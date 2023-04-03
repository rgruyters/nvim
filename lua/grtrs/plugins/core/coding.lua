return {
    -- Plugin: LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- LSP Support
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        lazy = true, -- load lsp config from grtrs.lsp
    },
    -- Plugin: Snippets
    {
        "L3MON4D3/LuaSnip",
        event = { "InsertEnter" },
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
            end,
        },
        keys = {
            {
                "<tab>",
                function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end,
                expr = true,
                silent = true,
                mode = "i",
            },
            { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
            {
                "<C-j>",
                function()
                    if require("luasnip").choice_active() then
                        require("luasnip").change_choice(1)
                    end
                end,
                mode = { "i", "s" }
            },
            {
                "<C-k>",
                function()
                    if require("luasnip").choice_active() then
                        require("luasnip").change_choice(-1)
                    end
                end,
                mode = { "i", "s" }
            },
        },
    },
    -- Plugin: Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        version = false, -- last release is way too old
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            local icons = require("grtrs.icons")

            return {
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
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
                formatting = {
                    kind_icons = icons.kind,
                    format = function(entry, item)
                        if icons.kind[item.kind] then
                            item.kind = icons.kind[item.kind] .. " " .. item.kind
                        end

                        if entry.source.name == "copilot" then
                            item.kind = icons.git.Octoface .. " " .. item.kind
                            item.kind_hl_group = "CmpItemKindCopilot"
                        end

                        return item
                    end,
                },
                enabled = function()
                    if require('cmp.config.context').in_treesitter_capture('comment') == true
                        or require('cmp.config.context').in_syntax_group('Comment')
                        or vim.bo.filetype == "TelescopePrompt" then -- HACK: disable completion when using Telescope
                        return false
                    else
                        return true
                    end
                end,
            }
        end
    },
    -- Plugin: for formatters and linters
    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = true, -- load null-ls config from grtrs.lsp.null-ls
    },
}
