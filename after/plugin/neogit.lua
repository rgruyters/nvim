local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
  return
end

neogit.setup {
  disable_commit_confirmation = true,
  commit_popup = {
    kind = "vsplit",
  },
  popup = {
    kind = "vsplit",
  },
  integrations = {
    diffview = true,
  },
}

vim.keymap.set("n", "<leader>gg", function() neogit.open({}) end)
vim.keymap.set("n", "<leader>gc", function() neogit.open({"commit"}) end)
