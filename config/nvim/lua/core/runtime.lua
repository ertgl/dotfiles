local M = {}

function M.is_headless()
  return #vim.api.nvim_list_uis() == 0
end

return M
