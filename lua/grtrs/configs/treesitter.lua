local status_configs_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_configs_ok then
    return
end

configs.setup({
    ensure_installed = {
        "hcl",
        "bash",
        "python",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "json",
        "lua",
        "vim",
        "yaml",
    }, -- one of "all" or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    matchup = {
        enable = true, -- mandatory, false will disable the whole extension
    },
    highlight = {
        enable = true, -- false will disable the whole extension
    },
    autopairs = {
        enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    autotag = {
        enable = true,
        disable = { "xml", "markdown" },
    },
})
