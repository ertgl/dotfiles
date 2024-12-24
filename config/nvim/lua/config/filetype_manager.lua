local M = {}

M.setup = function()
  vim.filetype.add({
    extension = {
      tmux = "tmux",
    },
    filename = {
      Brewfile = "ruby",
    },
  })
end

return M
