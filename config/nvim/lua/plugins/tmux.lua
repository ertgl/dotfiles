return {
  {
    "christoomey/vim-tmux-navigator",
    enabled = false,
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
