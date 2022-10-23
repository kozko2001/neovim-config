local M = {}

function M.plugin(use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'open file' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'find in files' })
      vim.keymap.set('n', '<leader>fs', builtin.treesitter, { desc = 'outline treesitter' })
      vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'select buffers' })

      -- Just by pressing once escape, close telescope
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
        },
      })
    end
  }
end

return M
