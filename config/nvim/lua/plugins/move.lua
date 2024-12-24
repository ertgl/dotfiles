return {
  {
    "echasnovski/mini.move",
    cond = not vim.g.nvcat and not vim.g.vscode,
    event = "BufEnter",
    config = function()
      local mini_move = require("mini.move")

      mini_move.setup({
        mappings = {
          left = "<A-h>",
          right = "<A-l>",
          down = "<A-j>",
          up = "<A-k>",
          line_left = "<A-h>",
          line_right = "<A-l>",
          line_down = "<A-j>",
          line_up = "<A-k>",
        },
        options = {
          reindent_linewise = true,
        },
      })

      vim.keymap.set("x", "<A-left>", [[<Cmd>lua MiniMove.move_selection('left')<CR>]], { desc = "Move left" })
      vim.keymap.set("x", "<A-right>", [[<Cmd>lua MiniMove.move_selection('right')<CR>]], { desc = "Move right" })
      vim.keymap.set("x", "<A-down>", [[<Cmd>lua MiniMove.move_selection('down')<CR>]], { desc = "Move down" })
      vim.keymap.set("x", "<A-up>", [[<Cmd>lua MiniMove.move_selection('up')<CR>]], { desc = "Move up" })

      vim.keymap.set("n", "<A-left>", [[<Cmd>lua MiniMove.move_line('left')<CR>]], { desc = "Move line left" })
      vim.keymap.set("n", "<A-right>", [[<Cmd>lua MiniMove.move_line('right')<CR>]], { desc = "Move line right" })
      vim.keymap.set("n", "<A-down>", [[<Cmd>lua MiniMove.move_line('down')<CR>]], { desc = "Move line down" })
      vim.keymap.set("n", "<A-up>", [[<Cmd>lua MiniMove.move_line('up')<CR>]], { desc = "Move line up" })
    end,
  },
}
