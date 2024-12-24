return {
  {
    "lewis6991/gitsigns.nvim",
    cond = not vim.g.vscode,
    event = "BufRead",
    opts = {},
  },
}
