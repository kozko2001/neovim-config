require "user.options"
require "user.packer"
require "user.utils"

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use {
    "hrsh7th/nvim-cmp",
    requires = { { "L3MON4D3/LuaSnip" } },
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
          end
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer' },
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true })
        },
      }
    end
  }
  use 'b0o/mapx.nvim'
  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup({
    })
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-t>', [[<Cmd>ToggleTerm <CR>]], opts)
      vim.keymap.set('t', '<C-w>_', [[<Cmd>wincmd _<CR>]], opts)
      vim.keymap.set('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-w><C-w>', [[<Cmd>wincmd w<CR>]], opts)
      vim.keymap.set('t', '<C-w>w', [[<Cmd>wincmd w<CR>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    vim.keymap.set('n', '<C-t>', [[<Cmd>ToggleTerm <CR>]], {})
    vim.keymap.set('n', '<leader>sl', [[<Cmd>ToggleTermSendCurrentLine<CR>]], {})
    vim.keymap.set('v', '<leader>st', [[<Cmd>ToggleTermSendVisualSelection<CR>]], {})
  end }
  -- theme
  local theme = require('user.theme')
  theme.plugin(use)

  -- auto reload on writing lua file
  require "user.reload"

  require('user.neovim-development').plugin(use)

  require("user.whichkey").plugin(use)

  require("user.treesitter").plugin(use)

  require("user.telescope").plugin(use)

  require("user.lsp").plugin(use)

  require("user.statusline").plugin(use)

  require("user.tab").plugin(use)

  require("user.comment").plugin(use)

  require("user.test").plugin(use)

  require("user.project").plugin(use)

  require("user.git").plugin(use)

  require("user.sidebar").plugin(use)

  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
