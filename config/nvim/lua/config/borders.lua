local M = {}

M.top_left = "┌"
M.top = "─"
M.top_right = "┐"
M.right = "│"
M.bottom_right = "┘"
M.bottom = "─"
M.bottom_left = "└"
M.left = "│"

M.as_dict = function()
  return {
    top_left = M.top_left,
    top = M.top,
    top_right = M.top_right,
    right = M.right,
    bottom_right = M.bottom_right,
    bottom = M.bottom,
    bottom_left = M.bottom_left,
    left = M.left,
  }
end

M.as_float_borders_array = function()
  return {
    { M.top_left, "FloatBorder" },
    { M.top, "FloatBorder" },
    { M.top_right, "FloatBorder" },
    { M.right, "FloatBorder" },
    { M.bottom_right, "FloatBorder" },
    { M.bottom, "FloatBorder" },
    { M.bottom_left, "FloatBorder" },
    { M.left, "FloatBorder" },
  }
end

M.setup = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  local border = M.as_float_borders_array()

  local super_util_open_floating_preview = vim.lsp.util.open_floating_preview

  local open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return super_util_open_floating_preview(contents, syntax, opts, ...)
  end

  vim.lsp.util.open_floating_preview = open_floating_preview

  vim.diagnostic.config({
    float = {
      border = border,
    },
  })
end

return M
