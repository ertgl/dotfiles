local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local M = {}

M.setup = function()
  M.install()
  M.configure()
  M.load()
end

M.install = function()
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"

    local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      lazyrepo,
      lazypath,
    })

    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
      }, true, {})
    end
  end
end

M.configure = function()
  vim.opt.rtp:prepend(lazypath)
end

M.load = function()
  local lazy = require("lazy")

  lazy.setup({
    change_detection = {
      enabled = not (vim.g.nvcat or vim.g.vscode),
      notify = false,
    },
    checker = {
      enabled = false,
    },
    headless = {
      colors = not vim.g.nvcat,
      log = not vim.g.nvcat,
      process = not vim.g.nvcat,
      task = not vim.g.nvcat,
    },
    install = {
      colorscheme = { "gruvbox" },
      missing = not (vim.g.nvcat or vim.g.vscode),
    },
    spec = {
      {
        import = "plugins",
      },
    },
    ui = {
      border = "single",
    },
  })
end

return M
