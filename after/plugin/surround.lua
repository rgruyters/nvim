local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
  vim.notify "Cannot load nvim-surround"
  return
end

surround.setup {}
