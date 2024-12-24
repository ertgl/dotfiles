return {
  {
    "nvim-lua/plenary.nvim",
    cond = not vim.g.nvcat and not vim.g.vscode,
  },

  {
    "folke/snacks.nvim",
    cond = not vim.g.nvcat and not vim.g.vscode,
    lazy = false,
    opts = {},
  },
}
