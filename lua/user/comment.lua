local M = {}

function M.plugin(use)
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
end

return M
