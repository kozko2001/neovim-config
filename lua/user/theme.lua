local M = {}

function M.plugin(use)
  use {
    'folke/tokyonight.nvim',
    config = function ()
      vim.cmd[[colorscheme tokyonight-night]]
    end
  }
end

return M
