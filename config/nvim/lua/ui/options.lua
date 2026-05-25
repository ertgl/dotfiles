local M = {}

function M.setup()
  if vim.g.vscode then
    vim.opt.cmdheight = 1
  else
    vim.o.cmdheight = 0
  end

  vim.o.cursorline = true

  vim.o.hlsearch = true

  vim.o.lazyredraw = false

  vim.o.list = true
  vim.opt.listchars:append("nbsp:␣")
  vim.opt.listchars:append("space:·")
  vim.opt.listchars:append("tab:>-")
  vim.opt.listchars:append("trail:~")

  vim.opt.matchpairs:append("<:>")

  vim.o.mouse = "a"

  vim.o.number = true
  vim.o.numberwidth = 4

  vim.o.relativenumber = true

  vim.o.scrolloff = 10

  vim.o.showmatch = true

  vim.o.showmode = false

  vim.o.signcolumn = "yes:1"

  vim.o.splitbelow = true
  vim.o.splitright = true

  vim.o.termguicolors = true
end

return M
