return {
  {
    "vidocqh/auto-indent.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufEnter",
    config = function()
      local auto_indent = require("auto-indent")
      local treesitter_indent = require("nvim-treesitter.indent")

      auto_indent.setup({
        lightmode = false,
        ignore_filetype = {},
        indentexpr = function(lnum)
          return treesitter_indent.get_indent(lnum)
        end,
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    cond = not vim.g.nvcat,
    event = "BufEnter",
    config = function()
      local autopairs = require("nvim-autopairs")

      autopairs.setup({
        disable_filetype = {
          "snacks_picker_input",
          "TelescopePrompt",
        },
      })
    end,
  },

  {
    "kylechui/nvim-surround",
    cond = not vim.g.nvcat,
    event = "BufEnter",
    config = function()
      local surround = require("nvim-surround")

      surround.setup({})
    end,
  },

  {
    "roobert/surround-ui.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VeryLazy",
    config = function()
      local surround_ui = require("surround-ui")
      local wk = require("which-key")

      surround_ui.setup({
        root_key = "cs",
      })

      surround_ui.setup({
        root_key = "cS",
      })

      wk.add({
        { "<leader>cs", group = "surround", proxy = "cs" },
        { "<leader>cS", group = "surround (multiline)", proxy = "cS" },
      })
    end,
  },

  {
    "echasnovski/mini.move",
    cond = not (vim.g.nvcat or vim.g.vscode),
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
