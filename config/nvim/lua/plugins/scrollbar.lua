return {
  {
    "petertriho/nvim-scrollbar",
    cond = not vim.g.nvcat and not vim.g.vscode,
    event = "VeryLazy",
    config = function()
      local scrollbar = require("scrollbar")

      scrollbar.setup({
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true,
          search = true,
        },
      })
    end,
  },
}
