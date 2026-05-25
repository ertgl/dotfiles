local M = {}

function M.get_pack_specs()
  return {
    {
      name = "treewalker",
      src = "https://github.com/aaronik/treewalker.nvim",
      version = "7baacb0efbdc2ac523ede90e266d685bc2227673",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local treewalker = require("treewalker")

  treewalker.setup({
    highlight = true,
    highlight_duration = 250,
    highlight_group = "CursorLine",
    jumplist = true,
    notifications = true,
    scope_confined = false,
    select = false,
  })

  M.setup_keymaps()
end

function M.setup_keymaps()
  vim.keymap.set({ "n", "v" }, "<C-k>", "<cmd>Treewalker Up<cr>", { silent = true })
  vim.keymap.set({ "n", "v" }, "<C-j>", "<cmd>Treewalker Down<cr>", { silent = true })
  vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>Treewalker Left<cr>", { silent = true })
  vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>Treewalker Right<cr>", { silent = true })

  vim.keymap.set("n", "<M-Up>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
  vim.keymap.set("n", "<M-Down>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
  vim.keymap.set("n", "<M-Left>", "<cmd>Treewalker SwapLeft<cr>", { silent = true })
  vim.keymap.set("n", "<M-Right>", "<cmd>Treewalker SwapRight<cr>", { silent = true })
end

return M
