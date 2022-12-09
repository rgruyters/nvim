local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    local icons = require("grtrs.icons")
    local signs = {

        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = true, -- disable virtual text
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
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local function lsp_highlight_document(client)
    -- if client.server_capabilities.document_highlight then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        return
    end
    illuminate.on_attach(client)
    -- end
end

local function attach_navic(client, bufnr)
    vim.g.navic_silence = true
    local status_ok, navic = pcall(require, "nvim-navic")
    if not status_ok then
        return
    end
    navic.attach(client, bufnr)
end

local function lsp_keymaps(bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<space>D", "<cmd>Telescope lsp_type_definitions<CR>", bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<space>lf", function() vim.lsp.buf.format { async = true, timeout_ms = 5000 } end, bufopts)
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
    attach_navic(client, bufnr)
end

function M.enable_format_on_save()
    vim.cmd([[
      augroup lsp_format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format { timeout_ms = 5000 }
      augroup end
    ]])
end

function M.disable_format_on_save()
    M.remove_augroup("lsp_format_on_save")
    print("Disabled formatting on save")
end

function M.toggle_format_on_save()
    if vim.fn.exists("#lsp_format_on_save#BufWritePre") == 0 then
        M.enable_format_on_save()
    else
        M.disable_format_on_save()
    end
end

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

vim.cmd([[ command! LspFormatOn execute 'lua require("grtrs.lsp.handlers").enable_format_on_save()' ]])
vim.cmd([[ command! LspFormatOff execute 'lua require("grtrs.lsp.handlers").disable_format_on_save()' ]])
vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("grtrs.lsp.handlers").toggle_format_on_save()' ]])

return M
