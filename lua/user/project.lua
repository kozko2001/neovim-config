local M = {}

function M.plugin(use)
  use {
    "ahmedkhalf/project.nvim",
    require = { { 'nvim-telescope/telescope.nvim' } },
    config = function()
      require("project_nvim").setup({
      })
      require('telescope').load_extension('projects')

      local keymap = vim.api.nvim_set_keymap
      keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "list projects" })

    end
  }

  -- each time you load a change a dir (AKA, load a new project)
  -- will execute the ~/.config/nvim/projects/{foldername}.lua
  use {
    'windwp/nvim-projectconfig',
    config = function()
      require('nvim-projectconfig').setup()
    end
  }

end

return M
