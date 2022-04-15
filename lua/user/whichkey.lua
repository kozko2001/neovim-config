local status_ok, whichkey= pcall(require, "which-key")
if not status_ok then
  vim.notify("whichkey was not loaded ")
  return
end

whichkey.setup {
}
