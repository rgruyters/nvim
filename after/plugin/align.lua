-- Align --
local nmap = function(keys, func, desc)
    if desc then
        desc = 'align: ' .. desc
    end

    vim.keymap.set('x', keys, func, { noremap = true, silent = true, desc = desc })
end

nmap("aa", "<cmd>lua require('align').align_to_char(1, true)<CR>", "Align 1 character") -- Aligns to 1 character, looking left
nmap("as", "<cmd>lua require('align').align_to_char(2, true, true)<CR>", "Align 2 characters") -- Aligns to 2 characters, looking left and with previews
nmap("aw", "<cmd>lua require('align').align_to_char(false, true, true)<CR>", "Aligns to string") -- Aligns to a string, looking left and with previews
nmap("ar", "<cmd>lua require('align').align_to_char(true, true, true)<CR>", "Align to Lua pattern") -- Aligns to a Lua pattern, looking left and with previews
