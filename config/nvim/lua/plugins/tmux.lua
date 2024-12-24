return {
  {
    "christoomey/vim-tmux-navigator",
    cond = not vim.g.vscode,
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
