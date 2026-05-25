local M = {}

function M.get_pack_specs()
  return {
    {
      name = "flash",
      src = "https://github.com/folke/flash.nvim",
      version = "b6346946d10d07998efee029fb0f7a593806d0cd",
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
