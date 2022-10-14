local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end

local harpoon_status_ok, harpoon = pcall(require, "harpoon")
if not harpoon_status_ok then
  return
end

local keymap = vim.keymap.set

local opts = { silent = true }

-- Harpoon
keymap("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts) -- Harpoon add marker
keymap("n", "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts) -- Harpoon UI
keymap("n", "<leader>.","<cmd>lua require('harpoon.ui').nav_next()<CR>", opts ) -- Harpoon Next
keymap("n", "<leader>,", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", opts) -- Harpoon Prev

telescope.load_extension "harpoon"

harpoon.setup {}
