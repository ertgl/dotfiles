local M = {}

---@param name string
M.disable_by_name = function(name)
  local lint = require("lint")

  for linter_idx, linter in ipairs(lint.linters) do
    if linter == name then
      table.remove(lint.linters, linter_idx)
    end
  end

  for _, linters in pairs(lint.linters_by_ft) do
    for linter_idx, linter in ipairs(linters) do
      if linter == name then
        table.remove(linters, linter_idx)
      end
    end
  end
end

M.is_enabled = function(name)
  local lint = require("lint")

  for _, linter in ipairs(lint.linters) do
    if linter == name then
      return true
    end
  end

  for _, linters in pairs(lint.linters_by_ft) do
    for _, linter in ipairs(linters) do
      if linter == name then
        return true
      end
    end
  end

  return false
end

return M
