

local M = {
  language = "yaml",
  lsp = {
    mason = "yamlls",
    settings = {
      yaml = {
        schemas = {
          ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.yaml",
        }
      }
    },
  },
}

return M

