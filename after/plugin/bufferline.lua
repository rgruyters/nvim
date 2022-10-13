local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    offsets = {
      { filetype = "NvimTree", text = "", padding = 1 },
      { filetype = "DiffviewFiles", text = nil, padding = 1 },
    },
    separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
    show_buffer_close_icons = false,
    show_close_icon = false,
    diagnostics = false,
  }
}
