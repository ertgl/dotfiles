local M = {}

---@return table
M.get_popup_filetypes = function()
  return {
    "snacks_picker_input",
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
      Corefile = "hcl",
    },
  })
end

return M
