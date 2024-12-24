return {
  {
    "rmagatti/auto-session",
    cond = not vim.g.vscode,
    lazy = false,
    priority = 90000,
    opts = {
      args_allow_files_auto_save = true,
      args_allow_single_directory = true,
      auto_create = false,
      auto_restore = true,
      auto_restore_last_session = false,
      auto_save = true,
      bypass_save_filetypes = {
        "netrw",
      },
      close_unsupported_windows = true,
      continue_restore_on_error = true,
      cwd_change_handling = false,
      enabled = true,
      lazy_support = true,
      log_level = "warn",
      lsp_stop_on_restore = false,
      root_dir = vim.fn.stdpath("data") .. "/sessions/",
      session_lens = {
        load_on_setup = true,
        mappings = {
          alternate_session = { "n", "<C-S>" },
          copy_session = { "n", "<C-Y>" },
          delete_session = { "n", "<C-D>" },
        },
        previewer = true,
        session_control = {
          control_filename = "session_control.json",
          control_dir = vim.fn.stdpath("data") .. "/auto_session/",
        },
      },
      show_auto_restore_notif = true,
      use_git_branch = true,
    },
    keys = {
      { "<leader>msl", "<cmd>SessionSearch<CR>", desc = "List sessions" },
      { "<leader>mss", "<cmd>SessionSave<CR>", desc = "Save session" },
    },
  },
}
