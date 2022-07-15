local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

-- vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#d08770", bg = "#303030" })
-- vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#d8dee9", bg = "#303030", bold = false })
-- vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D7BA7D", bg = "#252525" })
-- vim.api.nvim_set_hl(0, "SLProgress", { fg = "#d8dee9", bg = "#303030" })
-- vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#4c566a", bg = "#252525" })

local colors = {
  bg = "#2e3440",
  fg = "#bbc2cf",
  yellow = "#ebcb8b",
  cyan = "#8fbcbb",
  darkblue = "#5e81ac",
  green = "#a3be8c",
  orange = "#d08770",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  purple = "#b48ead",
  blue = "#81a1c1",
  red = "#bf616a",
}

local icons = require "user.icons"

-- local diagnostics = {
--   "diagnostics",
--   sources = { "nvim_diagnostic" },
--   sections = { "error", "warn" },
--   symbols = { error = " ", warn = " " },
--   colored = false,
--   always_visible = true,
-- }

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = true,
}

local location = {
  "location",
  padding = 0,
}

local scrollbar = {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = { fg = colors.yellow, bg = colors.bg },
    cond = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
  -- color = "Constant",
  colored = false,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diagnostics },
    lualine_x = { diff, spaces, filetype },
    lualine_y = { location },
    lualine_z = { scrollbar },
  },
}
