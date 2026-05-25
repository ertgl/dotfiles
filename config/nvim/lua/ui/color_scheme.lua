local M = {}

M.get_preferred = function()
  if vim.env.PREFERS_COLOR_SCHEME == "light" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end

M.setup = function()
  vim.o.background = M.get_preferred()
end

return M
