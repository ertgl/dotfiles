return {
  {
    "rmagatti/auto-session",
    cond = not (vim.g.nvcat or vim.g.vscode),
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
        "grug-far",
        "netrw",
        "ssr",
        "TelescopePrompt",
        "yazi",
      },
      close_unsupported_windows = true,
      continue_restore_on_error = true,
      cwd_change_handling = false,
      git_use_branch_name = true,
      lazy_support = true,
      log_level = "warn",
      lsp_stop_on_restore = true,
      root_dir = vim.fn.stdpath("data") .. "/sessions/",
      session_lens = {
        load_on_setup = true,
        mappings = {
          alternate_session = { "n", "<C-S>" },
          copy_session = { "n", "<C-Y>" },
          delete_session = { "n", "<C-D>" },
        },
        previewer = false,
        session_control = {
          control_filename = "session_control.json",
          control_dir = vim.fn.stdpath("data") .. "/auto_session/",
        },
        theme_conf = {
          layout_config = {
            height = 0.9,
            width = 0.9,
          },
        },
      },
      show_auto_restore_notif = false,
      suppressed_dirs = {
        "~/",
      },
    },
    keys = {
      { "<leader>msl", "<cmd>SessionSearch<CR>", desc = "List sessions" },
      { "<leader>mss", "<cmd>SessionSave<CR>", desc = "Save session" },
    },
  },
}
