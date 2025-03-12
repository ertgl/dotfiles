local M = {}

---@param config_file_names string[]
---@param cwd? nil | string
---@return nil | string
M.find_config_file_path = function(config_file_names, cwd)
  if cwd == nil then
    cwd = vim.fn.getcwd()
  end
  for _, config_file_name in ipairs(config_file_names) do
    local config_file_path = cwd .. "/" .. config_file_name
    if vim.fn.filereadable(config_file_path) == 1 then
      return config_file_path
    end
  end

  return nil
end

return M
