local M = {}

function M.get_pack_specs()
  return {
    {
      name = "ssr",
      src = "https://github.com/cshuaimin/ssr.nvim",
      version = "7c95cfa5836508f08ae833a4b31d2ed265560f64",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local ssr = require("ssr")

  ---@diagnostic disable-next-line: missing-fields
  ssr.setup({
    adjust_window = true,
    border = "single",
    keymaps = {
      close = "q",
      next_match = "n",
      prev_match = "N",
      replace_all = "<c-cr>",
      replace_confirm = "<cr>",
    },
  })

  M.setup_keymaps()
end

function M.setup_keymaps()
  local ssr = require("ssr")

  vim.keymap.set("n", "<Leader>sr", ssr.open, {
    desc = "Search and replace in the current buffer using Tree-sitter",
  })
end

return M
