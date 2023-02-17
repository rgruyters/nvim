local xmap = require("grtrs.functions").xmap

xmap("aa", "<cmd>lua require('align').align_to_char(1, true)<CR>", "Align 1 character") -- Aligns to 1 character, looking left
xmap("as", "<cmd>lua require('align').align_to_char(2, true, true)<CR>", "Align 2 characters") -- Aligns to 2 characters, looking left and with previews
xmap("aw", "<cmd>lua require('align').align_to_char(false, true, true)<CR>", "Aligns to string") -- Aligns to a string, looking left and with previews
xmap("ar", "<cmd>lua require('align').align_to_char(true, true, true)<CR>", "Align to Lua pattern") -- Aligns to a Lua pattern, looking left and with previews
