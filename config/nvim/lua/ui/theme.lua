local M = {}

function M.setup()
  M.setup_color_scheme()
end

function M.setup_color_scheme()
  require("ui.themes.gruvbox").setup()

  vim.cmd([[colorscheme gruvbox]])
end

return M
