return {
  {
    "christoomey/vim-tmux-navigator",
    cond = not (vim.g.nvcat or vim.g.vscode),
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
