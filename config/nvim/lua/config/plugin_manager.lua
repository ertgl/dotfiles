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
    checker = {
      enabled = false,
    },
    spec = {
      {
        import = "plugins",
      },
    },
  })
end

return M
