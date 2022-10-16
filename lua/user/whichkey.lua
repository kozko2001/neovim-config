local M = {}

function M.plugin(use)
  use {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup {}

      wk.register({
        ["<leader>"] = {
          f = {
            name = "+search/open",
          },
          b = {
            name = "+buffer",
          },
          h = {
            name = "+git",
          }
        }
      })

    end
  }
end

return M;
