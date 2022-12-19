local bufferline_loaded, bufferline = pcall(require, "bufferline")
if not bufferline_loaded then
    return
end

bufferline.setup {
  options = {
    separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
    show_buffer_close_icons = false,
    show_close_icon = false,
    diagnostics = false,
  }
}
