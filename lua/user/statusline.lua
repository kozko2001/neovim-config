local M = {}

function M.plugin(use)
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons'},
    config = function()
      require('lualine').setup({})
    end
  }
end

return M
