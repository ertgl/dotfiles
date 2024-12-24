return {
  {
    "christoomey/vim-tmux-navigator",
    cond = not vim.g.nvcat and not vim.g.vscode,
    event = "VimEnter",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
  },
}
