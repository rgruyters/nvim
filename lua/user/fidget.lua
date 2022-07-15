local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  vim.notify("Error loading fidget")
  return
end

fidget.setup()
