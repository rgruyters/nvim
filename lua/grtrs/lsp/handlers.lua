local M = {}

local cmp_nvim_lsp_loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_loaded then
    return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

local skipped_filetypes = { "markdown", "rst", "plaintext", "toml", "proto" }
local icons = require("grtrs.icons")

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false,
        signs = {
            active = signs, -- show signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
        automatic_configuration = {
            ---@usage list of filetypes that the automatic installer will skip
            skipped_filetypes = skipped_filetypes,
        },
    }

    vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
    local kmap = function(mode, keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    kmap('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    kmap('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    kmap('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    kmap('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    kmap('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    kmap('n', '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    kmap('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    kmap('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    kmap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
    kmap({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    kmap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    kmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    kmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    kmap('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    '[W]orkspace [L]ist Folders')

    -- LSP Formatting
    kmap('n', '<leader>f', vim.lsp.buf.format, '[F]ormat current buffer with LSP')
end

local function lsp_highlight_document(client)
    local illuminate_loaded, illuminate = pcall(require, "illuminate")
    if not illuminate_loaded then
        return
    end
    illuminate.on_attach(client)
end

M.on_attach = function(client, bufnr)
    lsp_highlight_document(client)
    lsp_keymaps(bufnr)
end

return M
