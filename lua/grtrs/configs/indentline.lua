local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

-- NOTE: To display end of line characters
-- vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")

indent_blankline.setup {
  char = "▏",
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  use_treesitter = true,
  use_treesitter_scope = 1,
  show_current_context = true,
  buftype_exclude = { "terminal", "nofile" },
  filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
    "DressingSelect",
  },
}
