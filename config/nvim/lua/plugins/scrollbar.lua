return {
  {
    "petertriho/nvim-scrollbar",
    cond = not (vim.g.nvcat or vim.g.vscode),
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
