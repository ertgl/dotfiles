return {
  {
    "github/copilot.vim",
    cond = not vim.g.nvcat and not vim.g.vscode,
    event = "BufRead",
  },
}
