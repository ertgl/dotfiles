local M = {}

M.get_preferred = function()
  local prefers_color_scheme = os.getenv("PREFERS_COLOR_SCHEME")
  if not prefers_color_scheme then
    prefers_color_scheme = vim.o.background
  end
  return prefers_color_scheme
end

M.setup = function()
  if vim.g.vscode then
    return
  end

  vim.o.background = M.get_preferred()
end

return M
