return {
  {
    "folke/flash.nvim",
    event = "BufEnter",
    opts = {},
    config = function()
      local flash = require("flash")

      vim.keymap.set({ "n", "o", "x" }, "<leader>sfj", flash.jump, {
        desc = "Jump",
      })

      vim.keymap.set({ "n", "o", "x" }, "<leader>sfr", flash.remote, {
        desc = "Jump to operate",
      })

      vim.keymap.set({ "n", "o", "x" }, "<leader>sfs", flash.treesitter_search, {
        desc = "Search using treesitter",
      })

      vim.keymap.set({ "n", "o", "x" }, "<leader>sfS", flash.treesitter, {
        desc = "Select using treesitter",
      })

      vim.keymap.set({ "c" }, "<c-s>", flash.toggle, {
        desc = "Toggle jumping with flash",
      })
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
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
