local catppuccin_status_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_status_ok then
    return
end

local colorscheme = "catppuccin"

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
catppuccin.setup()

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    return
end
