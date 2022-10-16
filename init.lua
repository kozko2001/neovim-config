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

  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
