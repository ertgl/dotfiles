return {
  {
    "nvim-lua/plenary.nvim",
    cond = not vim.g.vscode,
    lazy = false,
  },

  {
    "folke/snacks.nvim",
    cond = not vim.g.vscode,
    lazy = false,
    opts = {},
  },
}
