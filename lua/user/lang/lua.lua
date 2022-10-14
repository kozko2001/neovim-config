local M = {
  language = "lua",
  lsp = {
    mason = "sumneko_lua",
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  }
}

return M
