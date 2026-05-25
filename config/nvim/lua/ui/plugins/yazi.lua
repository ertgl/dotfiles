local M = {}

function M.get_pack_specs()
  return {
    {
      name = "yazi",
      src = "https://github.com/mikavilpas/yazi.nvim",
      version = vim.version.range('13.1'),
    }
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  M.disable_netrw_plugin()

  M.setup_yazi_boundary_plugin()

  local yazi = require("yazi")

  local borders = require("ui.borders")

  local borders_array = borders.as_float_borders_array()

  yazi.setup({
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
    yazi_floating_window_border = borders_array,
  })

  M.setup_keymaps()
end

function M.disable_netrw_plugin()
  vim.g.loaded_netrwPlugin = 1
end

function M.setup_yazi_boundary_plugin()
  vim.env.YAZI_BOUNDARY_ROOT_DIR = vim.fn.getcwd()

  vim.api.nvim_create_autocmd("DirChanged", {
    callback = function()
      vim.env.YAZI_BOUNDARY_ROOT_DIR = vim.fn.getcwd()
    end,
  })
end

function M.setup_keymaps()
  local yazi = require("yazi")

  vim.keymap.set({ "n" }, "<leader>fe", function()
    yazi.yazi()
  end, {
    desc = "Open file manager",
  })
end

return M
