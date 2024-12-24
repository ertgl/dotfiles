local M = {}

M.boot = function()
  M.pre()
  M.load_plugins()
  M.post()
end

M.pre = function()
  local borders = require("config.borders")
  local color_scheme = require("config.color_scheme")
  local option_manager = require("config.option_manager")

  color_scheme.setup()
  borders.setup()
  option_manager.setup()
end

M.load_plugins = function()
  local plugin_manager = require("config.plugin_manager")

  plugin_manager.setup()
end

M.post = function()
  local diagnostic_manager = require("config.diagnostic_manager")
  local lsp_manager = require("config.lsp_manager")
  local keymap_manager = require("config.keymap_manager")

  diagnostic_manager.setup()
  lsp_manager.setup()
  keymap_manager.setup()
end

return M
