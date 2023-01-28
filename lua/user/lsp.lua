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
      "ray-x/lsp_signature.nvim"
    },
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>ee', vim.diagnostic.open_float, opts)

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
        local function set_keymap(mode, lhs, rhs, _opts)
          map(mode, lhs, rhs, merge({
            buffer = bufnr,
          }, _opts or {}))
        end
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        set_keymap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', { desc = 'go to definition' })
        set_keymap('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>',
          { desc = 'go to implementation' })
        set_keymap('n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>',
          { desc = 'go to type definition' })
        set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', { desc = 'show refences' })
        set_keymap('n', 'K', vim.lsp.buf.hover, bufopts)
        -- diagnostics
        set_keymap('n', 'ge[', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'go to prev error' })
        set_keymap('n', 'ge]', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'go to next error' })
        set_keymap('n', 'gee', '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>',
          { desc = 'show error in cursor' })
        set_keymap('n', '<leader>ef', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'errors in file' })

        -- formatting
        set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.format({ async = true})<cr>', { desc = 'format file' })
        set_keymap('v', 'gf', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', { desc = 'format selected lines' })

        -- lsp workspace
        set_keymap('n', '<leader>ew', '<cmd>Telescope diagnostics<cr>', { desc = 'workspace diagnostic' })

        -- setup lsp_signature
        require "lsp_signature".on_attach({}, bufnr)
      end

      local lsp_flags = {
        debounce_text_changes = 150,
      }
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local default_settings = {}

      for _, language in pairs(languages) do
        require('lspconfig')[language.lsp.mason].setup({
          on_attach = on_attach,
          flags = lsp_flags,
          -- capabilities = capabilities,
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
      -- Rename
      keymap("n", "gR", "<cmd>Lspsaga rename<CR>", { silent = true, desc = 'rename' })
      keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { silent = true, desc = 'open definition in popup' })

    end,
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      vim.keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action,
        { buffer = args.buf, silent = true, desc = "Code action" })
    end
  })


end

return M
