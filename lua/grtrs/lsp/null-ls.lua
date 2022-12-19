local null_ls_loaded, null_ls = pcall(require, "null-ls")
if not null_ls_loaded then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
    debug = false,
    sources = {
        formatting.prettier.with {
            extra_filetypes = { "toml", "markdown" },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        },
        formatting.black.with { extra_args = { "--fast" } },
        formatting.shfmt,
        formatting.puppet_lint,
        formatting.terrafmt,
        formatting.gofmt,
        diagnostics.markdownlint,
        diagnostics.shellcheck,
        diagnostics.ansiblelint,
    },
}
