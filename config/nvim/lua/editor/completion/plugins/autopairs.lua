local M = {}

function M.get_pack_specs()
  return {
    {
      name = "autopairs",
      src = "https://github.com/windwp/nvim-autopairs",
      version = "59bce2eef357189c3305e25bc6dd2d138c1683f5",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local autopairs = require("nvim-autopairs")

  local file_types_module = require("core.file_types")

  local popup_file_types = file_types_module.get_popup_file_types()

  autopairs.setup({
    check_ts = true,
    disable_filetype = popup_file_types,
  })
end

return M
