local M = {}

M.setup = function()
  vim.diagnostic.config({
    float = {
      border = "single",
      severity_sort = true,
      shadow = true,
      source = true,
    },
  })
end

return M
