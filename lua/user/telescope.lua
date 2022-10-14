local M = {}

function M.plugin(use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', 'ff', builtin.find_files, {})
      vim.keymap.set('n', 'fg', builtin.live_grep, {})
      vim.keymap.set('n', 'fs', builtin.treesitter, {})
      vim.keymap.set('n', 'bb', builtin.buffers, {})
    end
  }
end

return M
