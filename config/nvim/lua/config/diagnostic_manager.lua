local M = {}

M.setup = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

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
