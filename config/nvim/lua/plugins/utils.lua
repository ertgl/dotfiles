return {
  {
    "nvim-lua/plenary.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
  },

  {
    "folke/snacks.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    lazy = false,
    opts = {},
  },
}
