local M = {}

function configure_jest()
  return require('neotest-jest')({
    jestCommand = function(a)
      local jest_command = "npm test --"
      local custom_jest_command = vim.g.kzk_jest_command
      print("executing jestCommand")
      print(a)

      local x=  custom_jest_command or jest_command
      print(x)
      return x
    end,
    jestConfigFile = "custom.jest.config.ts",
    env = { CI = true },
    cwd = function()
      return vim.fn.getcwd()
    end,
  })
end

function M.plugin(use)
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      'haydenmeade/neotest-jest',
    },
    config = function()
      require("neotest").setup({
        adapters = {
          configure_jest()
        }
      })

      local keymap = vim.api.nvim_set_keymap
      keymap("n", "<leader>tt", "<cmd>lua require('neotest').run.run()<CR>", { desc = 'run near test' })
      keymap("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
        { desc = 'run whole file test' })
      keymap("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
        { desc = 'debug near test' })
    end
  }
end

return M
