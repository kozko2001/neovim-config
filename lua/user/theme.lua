local M = {}

function M.plugin(use)
  use {
    'folke/tokyonight.nvim',
    config = function () 
      vim.cmd[[colorscheme tokyonight-day]]
    end
  }
end

return M
