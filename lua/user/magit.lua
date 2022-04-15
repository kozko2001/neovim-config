local status_ok, magit = pcall(require, "magit")
if not status_ok then
  vim.notify("magit was not loaded ")
  return
end
