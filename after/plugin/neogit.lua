local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
  return
end

neogit.setup {}

vim.keymap.set("n", "<leader>gg", function() neogit.open({}) end)
vim.keymap.set("n", "<leader>gS", function() neogit.open({"stage"}) end)
vim.keymap.set("n", "<leader>gc", function() neogit.open({"commit"}) end)
