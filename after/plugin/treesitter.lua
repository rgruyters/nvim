local nvim_treesitter_loaded, configs = pcall(require, "nvim-treesitter.configs")
if not nvim_treesitter_loaded then
    return
end

configs.setup({
    ensure_installed = {
        "help",
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
        "go",
        "terraform",
    }, -- one of "all" or a list of languages
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
    indent = { enable = true },
})
