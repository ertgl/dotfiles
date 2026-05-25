local M = {}

function M.get_pack_specs()
  return {
    {
      name = "auto-session",
      src = "https://github.com/rmagatti/auto-session",
      version = "97ef58c071221c45ff65d85e21e0f8504d0961dd",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local auto_session = require("auto-session")

  auto_session.setup({
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
      picker = "telescope",
      picker_opts = {
        -- border = "single",
        layout_config = {
          height = 0.9,
          width = 0.9,
        },
      },
      previewer = true,
      session_control = {
        control_filename = "session_control.json",
        control_dir = vim.fn.stdpath("data") .. "/auto_session/",
      },
    },
    show_auto_restore_notif = false,
    suppressed_dirs = {
      "~/",
    },
  })

  M.setup_keymaps()
end

function M.setup_keymaps()
  vim.keymap.set("n", "<leader>msc", "<cmd>AutoSession purgeOrphaned<CR>", {
    desc = "Clear orphaned sessions",
  })

  vim.keymap.set("n", "<leader>msl", "<cmd>AutoSession search<CR>", {
    desc = "List sessions",
  })

  vim.keymap.set("n", "<leader>mss", "<cmd>AutoSession save<CR>", {
    desc = "Save session",
  })
end

return M
