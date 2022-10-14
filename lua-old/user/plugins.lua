local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- Colorschemes
  use "folke/tokyonight.nvim"
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use


  -- LSP
  use {
    "neovim/nvim-lspconfig" ,
    requires = {
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function () 
      local on_attach = function (client, bufnr)
      end
      local lsp_flags = {
        debounce_text_changes = 150,
      }
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      for _, server in ipairs({
        'pyright',
        'tsserver',
        'sumneko_lua',
        'jsonls',
        'yamlls',
        'taplo',
        'eslint',
      }) do
        settings = {}
        require('lspconfig')[server].setup({
          on_attach = on_attach,
          flags = lsp_flags,
          capabilities = capabilities,
          settings = settings,
        })
      end
    end 
  }-- enable LSP

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Which Key (shows a menu of Keybinding)
  use "folke/which-key.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- Comments
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- Better mapping
  use 'b0o/mapx.nvim'

  -- tree
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'

  -- magit!!
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- Markdown preview
  use {"ellisonleao/glow.nvim", branch = 'main'}

  -- Debugging - Dap
  use 'nvim-telescope/telescope-dap.nvim'
 	use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  -- CD to project depending on LSP or .git folder
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end
  }

  -- Initial screen
  use { "goolord/alpha-nvim" }

  -- Testing :)
  use({
    'nvim-neotest/neotest',
    requires = {
      'haydenmeade/neotest-jest',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-jest')({
            jestCommand = "npm test --",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        }
      })
    end
  })

  -- Mason (LSP)
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  }


  use {
    'williamboman/mason-lspconfig.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'tsserver',
          'pyright',
          'sumneko_lua',
          'jsonls',
          'yamlls',
          'eslint',
        },
      })
    end,
  }

  use {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    requires = {
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'prettierd',
          'black',
          'isort',
          'cspell',
          'stylua',
          'debugpy',
        },
      })
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
  require("packer").sync()
end
end)
