local status_configs_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_configs_ok then
  vim.notify("Error loading treesitter configs")
  return
end

local status_parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not status_parsers_ok then
  vim.notify("Error loading treesitter parsers")
  return
end

local parser_config = parsers.get_parser_configs()
parser_config.puppet = {
  install_info = {
    url = "https://github.com/neovim-puppet/tree-sitter-puppet.git",
    branch = "main",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  filetype = "puppet",
}

configs.setup({
  ensure_installed = "all", -- one of "all" or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "css", "markdown" }, -- list of language that will be disabled
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
