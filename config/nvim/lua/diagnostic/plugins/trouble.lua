local M = {}

function M.get_pack_specs()
  return {
    {
      name = "trouble",
      src = "https://github.com/folke/trouble.nvim",
      version = "bd67efe408d4816e25e8491cc5ad4088e708a69a",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local trouble = require("trouble")

  trouble.setup({
    icons = {
      indent = {
        middle = " ",
        last = " ",
        top = " ",
        ws = "│  ",
      },
    },
    modes = {
      diagnostics = {
        groups = {
          {
            "filename",
            format = "{file_icon} {basename:Title} {count}",
          },
        },
      },
      test = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },
  })
end

return M
