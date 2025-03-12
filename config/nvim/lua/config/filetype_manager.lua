local M = {}

---@return table
M.get_popup_filetypes = function()
  return {
    "TelescopePrompt",
    "yazi",
  }
end

M.setup = function()
  vim.filetype.add({
    extension = {
      gitconfig = "gitconfig",
      pcss = "css",
      tmux = "tmux",
    },
    filename = {
      Brewfile = "ruby",
    },
  })
end

return M
