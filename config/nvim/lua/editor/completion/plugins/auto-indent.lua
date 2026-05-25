local M = {}

function M.get_pack_specs()
  return {
    {
      name = "auto-indent",
      src = "https://github.com/vidocqh/auto-indent.nvim",
      version = "46801cf8857d42a20a73c40b0a5d3dfe8b2b6192",
    },
  }
end

function M.setup() end
function M.setupa()
  if vim.g.vscode then
    return
  end

  local auto_indent = require("auto-indent")
  -- local treesitter_indent = require("nvim-treesitter.indent")

  auto_indent.setup({
    lightmode = false,
    ignore_filetype = {},
    -- indentexpr = function(lnum)
    --   return treesitter_indent.get_indent(lnum)
    -- end,
  })
end

return M
