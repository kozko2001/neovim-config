local status_ok, _ = pcall(require, "neogit")
if not status_ok then
  vim.notify("magit was not loaded ")
  return
end
