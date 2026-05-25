local M = {}

M.setup = function()
  if vim.g.vscode then
    return
  end

  local borders = require("ui.borders")

  local borders_array = borders.as_float_borders_array()

  vim.diagnostic.config({
    float = {
      border = borders_array,
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
