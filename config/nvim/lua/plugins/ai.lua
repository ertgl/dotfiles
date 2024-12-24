return {
  {
    "github/copilot.vim",
    cond = not vim.g.vscode,
    event = "BufRead",
  },
}
