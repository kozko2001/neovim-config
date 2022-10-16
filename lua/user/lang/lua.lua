local M = {
  language = "lua",
  lsp = {
    mason = "sumneko_lua",
    settings = {
      Lua = {
        workspace = {
          library = {
            ['/usr/share/nvim/runtime/lua'] = true,

            ['/usr/share/nvim/runtime/lua/lsp'] = true,

            ['/usr/share/awesome/lib'] = true
          }
        },
        diagnostics = {
          globals = { 'vim', 'use', 'awesome', 'client', 'root' },
        },
      },
    },
  }
}

return M
