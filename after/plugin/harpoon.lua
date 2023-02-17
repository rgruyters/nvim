local nmap = require("grtrs.functions").nmap

local telescope_loaded, telescope = pcall(require, "telescope")
if not telescope_loaded then
    return
end

local harpoon_loaded, harpoon = pcall(require, "harpoon")
if not harpoon_loaded then
    return
end

-- Harpoon
nmap("<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", "[A]dd marker") -- Harpoon add marker
nmap("<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Quick Menu") -- Harpoon UI
nmap("<leader>.","<cmd>lua require('harpoon.ui').nav_next()<CR>", "Next") -- Harpoon Next
nmap("<leader>,", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Previous") -- Harpoon Prev

telescope.load_extension("harpoon")

harpoon.setup {}
