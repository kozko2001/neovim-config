local M = {}

function M.plugin(use)
  use {
    "folke/neodev.nvim",
    config = function ()
      require('neodev').setup({})
    end
  }
end

return M;
