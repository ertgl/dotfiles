local M = {}

M.setup = function()
  vim.filetype.add({
    extension = {
      gitconfig = "gitconfig",
      tmux = "tmux",
    },
    filename = {
      Brewfile = "ruby",
    },
  })
end

return M
