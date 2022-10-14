---@diagnostic disable: undefined-global
local M = {}

local utils = require('user.utils')

local default_lsp_to_install = {
  'pyright',
  'jsonls',
  'yamlls',
  'taplo',
  'eslint',
}

languages = utils.load_language_config()

function lsp_to_install()
  local p = utils.map(languages, function(x)
    return x.lsp.mason
  end)
  p = utils.values(p)
  p = utils.concat(p, default_lsp_to_install)
  return p
end

local function install_lsp(use)
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

        ensured_installed = lsp_to_install()
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
end

function M.plugin(use)

  install_lsp(use)

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "ray-x/lsp_signature.nvim"
    },
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

      local function merge(...)
        return vim.tbl_deep_extend('force', ...)
      end

      local function map(mode, lhs, rhs, _opts)
        local defaults = {
          silent = true,
          noremap = true,
        }
        vim.keymap.set(mode, lhs, rhs, merge(defaults, _opts or {}))
      end

      local on_attach = function(_, bufnr)
        local function set_keymap(mode, lhs, rhs)
          map(mode, lhs, rhs, {
            buffer = bufnr,
          })
        end

        set_keymap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
        set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
        set_keymap('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')
        set_keymap('n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>')
        set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')

        -- diagnostics
        set_keymap('n', 'ge[', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        set_keymap('n', 'ge]', '<cmd>lua vim.diagnostic.goto_next()<cr>')
        set_keymap('n', 'gee', '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>')
        set_keymap('n', '<leader>ge', '<cmd>Telescope diagnostics bufnr=0<cr>')



        -- formatting
        set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<cr>')
        set_keymap('v', 'gf', '<cmd>lua vim.lsp.buf.range_formatting()<cr>')

        -- lsp workspace
        set_keymap('n', '<leader>ew', '<cmd>Telescope diagnostics<cr>')

        -- setup lsp_signature
        require "lsp_signature".on_attach({}, bufnr)
      end

      local lsp_flags = {
        debounce_text_changes = 150,
      }
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local default_settings = {}

      for _, language in pairs(languages) do
        require('lspconfig')[language.lsp.mason].setup({
          on_attach = on_attach,
          flags = lsp_flags,
          capabilities = capabilities,
          settings = language.lsp.settings or default_settings,
        })
      end
    end
  } -- enable LSP

  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      local saga = require("lspsaga")
      local keymap = vim.keymap.set

      saga.init_lsp_saga({
        -- your configuration
        code_action_icon = "ﯦ"
      })
      -- Code action
      keymap({ "n", "v" }, "ga", "<cmd>Lspsaga code_action<CR>", { silent = true })

      -- Rename
      keymap("n", "gR", "<cmd>Lspsaga rename<CR>", { silent = true })
      keymap("n", "gpd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

    end,
  })

end

return M
