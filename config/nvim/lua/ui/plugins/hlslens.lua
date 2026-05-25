local M = {}

function M.get_pack_specs()
  return {
    {
      name = "hlslens",
      src = "https://github.com/kevinhwang91/nvim-hlslens",
      version = "be2d7b2be01860b5445a007ff2bc72b29896db6b",
    },
  }
end

function M.setup()
  local hlslens = require("hlslens")

  hlslens.setup()

  M.setup_keymaps()
end

function M.setup_keymaps()
  vim.keymap.set({ "n" }, "<esc>", "<cmd>nohlsearch<cr>", {
    desc = "Clear search highlights",
    noremap = true,
    silent = true,
  })
end

return M
