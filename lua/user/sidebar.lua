local M = {}

function M.plugin(use)
  use({
    "sidebar-nvim/sidebar.nvim",
    config = function()
      local sidebar = require("sidebar-nvim")
      sidebar.setup({
        sections = { "git", "diagnostics", "buffers", "files", "symbols" }
      })

      vim.keymap.set('n', '<leader><leader>', [[<Cmd>lua require("sidebar-nvim").toggle({focus = true})<CR>]], { desc = "Open sidebar" })


    end

  })
end

return M
