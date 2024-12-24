local M = {}

M.setup = function()
  vim.o.autochdir = false
  vim.o.sessionoptions = "blank,buffers,curdir,folds,help,localoptions,tabpages,terminal,winpos,winsize"

  vim.o.swapfile = false

  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"

  vim.opt.clipboard:append({ "unnamedplus" })

  vim.o.mouse = "a"

  vim.g.autoindent = true
  vim.g.breakindent = true
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
  local listchars_sep = ""
  if vim.opt.listchars ~= "" then
    listchars_sep = ","
  end
  vim.opt.listchars = vim.opt.listchars + listchars_sep + "nbsp:␣,space:·,tab:>-,trail:~" -- eol:↵

  vim.o.title = true

  vim.o.splitbelow = true
  vim.o.splitright = true

  vim.o.scrolloff = 10
  vim.wo.wrap = false

  vim.o.termguicolors = true

  vim.o.cmdheight = 0
  vim.o.showmode = false

  vim.o.signcolumn = "yes:1"
  vim.o.statuscolumn = "%s %3l │ %{v:relnum} %C"

  vim.o.number = true
  vim.o.numberwidth = 4
  vim.o.relativenumber = true

  vim.o.cursorline = true

  vim.o.showmatch = true

  vim.o.completeopt = "menuone,noselect"
end

return M
