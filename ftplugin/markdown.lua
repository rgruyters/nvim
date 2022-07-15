local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  vim.notify("Cannot load which-key for Markdown")
  return
end

vim.cmd("set tw=80 wrap linebreak")

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  m = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
}

which_key.register(mappings, opts)
