return {
  {
    "mikavilpas/yazi.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
      floating_window_scaling_factor = 0.9,
      keymaps = {
        show_help = "<f1>",
      },
      open_for_directories = true,
      yazi_floating_window_border = "single",
    },
    keys = {
      {
        "<leader>fe",
        mode = { "n" },
        "<cmd>Yazi<cr>",
        desc = "Open file manager in current buffer directory",
      },
      {
        "<leader>fme",
        mode = { "n" },
        "<cmd>Yazi<cr>",
        desc = "Open file manager in current buffer directory",
      },
      {
        "<leader>fmr",
        mode = { "n" },
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last file management session",
      },
    },
  },
}
