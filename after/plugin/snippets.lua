local luasnip_lazyload_loaded, luasnip_lazyload = pcall(require, "luasnip.loaders.from_vscode")
if not luasnip_lazyload_loaded then
    return
end

-- Load default vscode style snippets
luasnip_lazyload.lazy_load()

-- Load my custom snippets
luasnip_lazyload.lazy_load({ paths = { "./snippets" }} )
