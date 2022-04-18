local status_ok, alpha = pcall(require, "alpha")

if not status_ok then
  vim.notify("alpha was not loaded ")
  return
end

local dashboard = require'alpha.themes.dashboard'


dashboard.section.header.val = {
  [[                               __                ]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
  dashboard.button( "SPC - f", "  Search files"),
  dashboard.button( "SPC - SPC - p", "  Load projects"),
  dashboard.button( "SPC - s - c", "  colorschemes"),
  dashboard.button( "SPC - s - r", "  Recent files"),
  dashboard.button( "SPC - e", "  File Explorer"),
  dashboard.button( "q", "  Quit NVIM" , ":qa<CR>"),
}
local handle = io.popen('fortune')
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune
dashboard.config.opts.noautocmd = true
vim.cmd[[autocmd User AlphaReady echo 'ready']]
alpha.setup(dashboard.config)


local alpha_group = vim.api.nvim_create_augroup("AlphaGroupOnEnter", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function ()  vim.api.nvim_command('Alpha') end,
  group = alpha_group,
})

