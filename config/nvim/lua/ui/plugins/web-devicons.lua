local M = {}

function M.get_pack_specs()
  return {
    {
      name = "nvim-web-devicons",
      src = "https://github.com/nvim-tree/nvim-web-devicons",
      version = "d7462543c9e366c0d196c7f67a945eaaf5d99414",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local web_devicons = require("nvim-web-devicons")

  web_devicons.setup({
    color_icons = true,
    default = true,
  })

  vim.cmd([[
    augroup nvim_tree_nvim_web_devicons_colors
      autocmd! ColorScheme * lua require("nvim-web-devicons").refresh()
    augroup END
  ]])
end

return M
