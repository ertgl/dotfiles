local M = {}

function M.setup()
  vim.o.autochdir = false

  vim.o.fsync = true

  vim.g.mapleader = " "
  vim.g.maplocalleader = ","

  vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,localoptions,tabpages,terminal,winpos,winsize"

  vim.o.swapfile = false

  vim.o.title = true
end

return M
