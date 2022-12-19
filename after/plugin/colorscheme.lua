local catppuccin_loaded, catppuccin = pcall(require, "catppuccin")
if not catppuccin_loaded then
    return
end

local colorscheme = "catppuccin"

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
catppuccin.setup()

local colorscheme_loaded, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_loaded then
    return
end
