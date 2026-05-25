local M = {}

function M.get_pack_specs()
  return {
    {
      name = "flash",
      src = "https://github.com/folke/flash.nvim",
      version = "fcea7ff883235d9024dc41e638f164a450c14ca2",
    },
  }
end

function M.setup()
  M.setup_keymaps()
end

function M.setup_keymaps()
  local flash = require("flash")

  vim.keymap.set({ "n", "o", "x" }, "<leader>jj", flash.jump, {
    desc = "Jump",
  })

  vim.keymap.set({ "n", "o", "x" }, "<leader>jr", flash.remote, {
    desc = "Jump to operate",
  })

  vim.keymap.set({ "n", "o", "x" }, "<leader>js", flash.treesitter_search, {
    desc = "Jump using Tree-sitter",
  })

  vim.keymap.set({ "n", "o", "x" }, "<leader>jS", flash.treesitter, {
    desc = "Select using Tree-sitter",
  })
end

return M
