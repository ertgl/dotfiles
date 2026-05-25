local M = {}

function M.get_pack_specs()
  return {
    {
      name = "scrollbar",
      src = "https://github.com/petertriho/nvim-scrollbar",
      version = "f8e87b96cd6362ef8579be456afee3b38fd7e2a8",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local scrollbar = require("scrollbar")

  scrollbar.setup({
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = true,
      search = true,
    },
  })
end

return M
