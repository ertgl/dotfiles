return {
  {
    "folke/flash.nvim",
    cond = not vim.g.nvcat,
    event = "BufEnter",
    opts = {},
    config = function()
      local flash = require("flash")

      vim.keymap.set({ "n", "o", "x" }, "<leader>jj", flash.jump, {
        desc = "Jump",
      })

      vim.keymap.set({ "n", "o", "x" }, "<leader>jr", flash.remote, {
        desc = "Jump to operate",
      })

      vim.keymap.set({ "n", "o", "x" }, "<leader>js", flash.treesitter_search, {
        desc = "Search using treesitter",
      })

      vim.keymap.set({ "n", "o", "x" }, "<leader>jS", flash.treesitter, {
        desc = "Select using treesitter",
      })

      vim.keymap.set({ "c" }, "<c-s>", flash.toggle, {
        desc = "Toggle jumping with flash",
      })
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    cond = not vim.g.nvcat,
    event = "BufRead",
    opts = {},
    keys = {
      {
        "<esc>",
        "<cmd>nohlsearch<cr>",
        desc = "Clear search highlights",
      },
      {
        "<leader>sc",
        "<cmd>nohlsearch<cr>",
        desc = "Clear search highlights",
      },
    },
  },
}
