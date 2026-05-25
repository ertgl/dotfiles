local M = {}

function M.get_pack_specs()
  return {
    {
      name = "treesitter-context",
      src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
      version = "529ee357b8c03d76ff71233afed68fd0f5fe10b1",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local treesitter_context = require("treesitter-context")

  treesitter_context.setup({
    enable = true,
    line_numbers = true,
    max_lines = 0,
    min_window_height = 0,
    mode = "cursor",
    multiline_threshold = 20,
    multiwindow = true,
    on_attach = nil,
    separator = "-",
    trim_scope = "outer",
    zindex = 20,
  })
end

return M
