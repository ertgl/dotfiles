return {
  {
    "mikavilpas/yazi.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    lazy = false,
    priority = 200000,
    opts = {
      floating_window_scaling_factor = 0.95,
      highlight_hovered_buffers_in_same_directory = true,
      hooks = {
        ---@diagnostic disable-next-line: unused-local
        yazi_opened = function(preselected_path, yazi_buffer_id, config)
          vim.api.nvim_buf_set_name(yazi_buffer_id, "")
        end,
      },
      keymaps = {
        change_working_directory = "<c-;>",
        copy_relative_path_to_selected_files = "<c-y>",
        cycle_open_buffers = "<tab>",
        grep_in_directory = "<c-g>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-s>",
        open_file_in_tab = "<c-t>",
        replace_in_directory = "<c-r>",
        send_to_quickfix_list = "<c-q>",
        show_help = "<f1>",
      },
      open_for_directories = true,
      open_multiple_tabs = true,
      yazi_floating_window_border = "single",
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1

      vim.env.YAZI_ROOT_DIR = vim.fn.getcwd()

      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          vim.env.YAZI_ROOT_DIR = vim.fn.getcwd()
        end,
      })
    end,
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
