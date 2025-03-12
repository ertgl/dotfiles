return {
  {
    "nvim-tree/nvim-web-devicons",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VeryLazy",
    config = function()
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
    end,
  },
}
