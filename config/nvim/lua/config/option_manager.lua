local M = {}

M.setup = function()
  vim.o.autochdir = false

  vim.o.sessionoptions = "blank,buffers,curdir,folds,help,localoptions,tabpages,terminal,winpos,winsize"

  vim.o.fsync = true
  vim.o.swapfile = false

  vim.g.mapleader = " "
  vim.g.maplocalleader = ","

  vim.opt.clipboard:append({ "unnamedplus" })

  vim.o.mouse = "a"

  vim.o.autoindent = true
  vim.o.breakindent = true
  vim.o.copyindent = true
  vim.o.expandtab = false
  vim.o.shiftwidth = 0
  vim.o.smartindent = true
  vim.o.softtabstop = 0
  vim.o.tabstop = 4

  vim.g.editorconfig = true

  vim.o.hlsearch = true
  vim.o.incsearch = true
  vim.o.ignorecase = true
  vim.o.smartcase = true

  vim.o.list = true

  vim.opt.listchars:append("nbsp:␣")
  vim.opt.listchars:append("space:·")
  vim.opt.listchars:append("tab:>-")
  vim.opt.listchars:append("trail:~")
  -- vim.opt.listchars:append("eol:↵")

  vim.o.title = true

  vim.o.splitbelow = true
  vim.o.splitright = true

  vim.o.scrolloff = 10
  vim.o.wrap = false

  vim.o.termguicolors = true
  vim.o.lazyredraw = false

  vim.o.cmdheight = 0
  vim.o.showmode = false

  vim.o.signcolumn = "yes:1"

  vim.o.number = true
  vim.o.numberwidth = 4
  vim.o.relativenumber = true

  vim.o.foldlevelstart = 99
  vim.o.foldmethod = "syntax"

  vim.o.cursorline = true

  vim.o.showmatch = true
  vim.opt.matchpairs:append("<:>")

  vim.o.completeopt = "fuzzy,menuone,noinsert,noselect,popup,preview"
end

return M
