local M = {}

local utils = require('user.utils')

function config()
  local map = vim.api.nvim_set_keymap

  local opts = { noremap = true, silent = true }
  local genOpsWithDescription = function(desc)
    return utils.merge(opts, { desc = desc })
  end

  -- Move to previous/next
  map('n', '<leader>bn', '<Cmd>BufferPrevious<CR>', genOpsWithDescription('previous buffer'))
  map('n', '<leader>bp', '<Cmd>BufferNext<CR>', genOpsWithDescription('next buffer'))
  -- Goto buffer in position...
  map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
  map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
  map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
  map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
  map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
  map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
  map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
  map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
  map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
  map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
  -- Pin/unpin buffer
  map('n', '<leader>bp', '<Cmd>BufferPin<CR>', genOpsWithDescription('pin tab'))
  -- Close buffer
  map('n', '<leader>bc', '<Cmd>BufferClose<CR>', genOpsWithDescription('close buffer'))
  -- Wipeout buffer
  --                 :BufferWipeout
  -- Close commands
  --                 :BufferCloseAllButCurrent
  --                 :BufferCloseAllButPinned
  --                 :BufferCloseAllButCurrentOrPinned
  --                 :BufferCloseBuffersLeft
  --                 :BufferCloseBuffersRight
end

function M.plugin(use)
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      config()
    end
  }
end

return M