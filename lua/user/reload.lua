local M = {}

-- https://neovim.discourse.group/t/reload-init-lua-and-all-require-d-scripts/971/18

function M.ReloadConfig()
    require('plenary.reload').reload_module('user')
    vim.cmd [[luafile $MYVIMRC]]
end


local api = vim.api

local reload_config = api.nvim_create_augroup("ReloadConfigOnWriteLuaFile", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.lua",
  callback = M.ReloadConfig,
  group = reload_config,
})

return M
