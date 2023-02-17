local M = {}

M.nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { noremap = true, silent = true, desc = desc })
end

M.imap = function(keys, func, desc)
    vim.keymap.set('i', keys, func, { noremap = true, silent = true, desc = desc })
end

M.xmap = function(keys, func, desc)
    vim.keymap.set('x', keys, func, { noremap = true, silent = true, desc = desc })
end

return M
