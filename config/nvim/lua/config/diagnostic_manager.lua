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
    severity_sort = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    virtual_lines = false,
    virtual_text = false,
  })
end

return M
