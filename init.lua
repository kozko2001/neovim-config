require "user.options"
require "user.packer"
require "user.utils"

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "hrsh7th/nvim-cmp"
  use 'b0o/mapx.nvim'

  -- theme
  local theme = require('user.theme')
  theme.plugin(use)

  -- auto reload on writing lua file
  require "user.reload"

  require("user.treesitter").plugin(use)

  require("user.telescope").plugin(use)

  require("user.lsp").plugin(use)

  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
