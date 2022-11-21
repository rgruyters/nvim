local config_ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not config_ok then
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
