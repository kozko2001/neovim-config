local M = {}

function M.merge(...)
  return vim.tbl_deep_extend('force', ...)
end

function M.map(tbl, f)
  local t = {}
  for k, v in pairs(tbl) do
    t[k] = f(v)
  end
  return t
end

function M.values(tbl)
  return vim.tbl_values(tbl)
end

function M.concat(l1, l2)
  for _, v in ipairs(l2) do
    table.insert(l1, v)
  end
  return l1

end

function M.load_language_config()
  local lang = {}

  for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/user/lang', [[v:val =~ '\.lua$']])) do
    local data = require('user.lang.' .. file:gsub('%.lua$', ''))
    lang[data.language] = data
  end

  return lang
end

return M
