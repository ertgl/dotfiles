local M = {}

M.boot = function()
  M.pre()
  M.load_plugins()
  M.post()
end

M.pre = function()
  local backdrop = require("config.backdrop")
  local borders = require("config.borders")
  local color_scheme = require("config.color_scheme")
  local cwd_manager = require("config.cwd_manager")
  local fold_manager = require("config.fold_manager")
  local filetype_manager = require("config.filetype_manager")
  local option_manager = require("config.option_manager")
  local statuscolumn_manager = require("config.statuscolumn_manager")

  backdrop.setup()
  borders.setup()
  color_scheme.setup()
  cwd_manager.setup()
  fold_manager.setup()
  filetype_manager.setup()
  option_manager.setup()
  statuscolumn_manager.setup()
end

M.load_plugins = function()
  local plugin_manager = require("config.plugin_manager")

  plugin_manager.setup()
end

M.post = function()
  local diagnostic_manager = require("config.diagnostic_manager")
  local keymap_manager = require("config.keymap_manager")
  local lsp_manager = require("config.lsp_manager")

  diagnostic_manager.setup()
  keymap_manager.setup()
  lsp_manager.setup()
end

return M
