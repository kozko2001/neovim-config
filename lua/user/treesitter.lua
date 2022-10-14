local M = {}

function M.plugin(use)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "tsx", "json", "yaml", "html", "javascript", "typescript", "bash", "toml", "dockerfile", "lua", "rust" },
        indent = {
          enable = true
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
      }
    end
  }

  -- enable folding using treesitter
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
end

return M
