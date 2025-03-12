local M = {}

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
