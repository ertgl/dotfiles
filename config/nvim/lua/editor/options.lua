local M = {}

function M.setup()
  vim.o.autoindent = true

  vim.opt.clipboard:append({ "unnamedplus" })

  vim.o.completeopt = "fuzzy,menuone,noinsert,noselect,popup,preview"

  vim.o.copyindent = true

  vim.g.editorconfig = true

  vim.o.expandtab = false

  vim.o.foldlevelstart = 99
  vim.o.foldmethod = "syntax"

  vim.o.smarttab = true

  vim.o.softtabstop = 0

  vim.o.shiftwidth = 0

  vim.o.tabstop = 4

  vim.o.wrap = false
end

return M
