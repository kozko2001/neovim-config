local M = {}

function configure_jest()
  return require('neotest-jest')({
    jestCommand = "npm run test:unit --",
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
      keymap("n", "<leader>tt", "<cmd>lua require('neotest').run.run()<CR>", {desc = 'run near test'})
      keymap("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", {desc = 'run whole file test'})
      keymap("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", {desc = 'debug near test'})
    end
  }
end

return M
