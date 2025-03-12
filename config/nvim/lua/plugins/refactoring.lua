return {
  {
    "cshuaimin/ssr.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufEnter",
    config = function()
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

      vim.keymap.set("n", "<Leader>sr", ssr.open, {
        desc = "Search and replace in the current buffer using Tree-sitter",
      })
    end,
  },

  {
    "MagicDuck/grug-far.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VimEnter",
    config = function()
      local grug_far = require("grug-far")

      grug_far.setup({
        debounceMs = 500,
        engines = {
          astgrep = {
            path = "sg",
            placeholders = {
              enabled = false,
            },
          },
          ripgrep = {
            path = "rg",
            placeholders = {
              enabled = false,
            },
          },
        },
        helpLine = {
          enabled = false,
        },
        icons = {
          enabled = false,
        },
        maxLineLength = -1,
        maxSearchMatches = nil,
        maxWorkers = vim.uv.available_parallelism(),
        minSearchChars = 1,
        normalModeSearch = false,
        openTargetWindow = {
          preferredLocation = "right",
        },
        windowCreationCommand = "tab",
        startInInsertMode = false,
      })

      vim.keymap.set("n", "<Leader>sR", [[<cmd>GrugFar<cr>]], {
        desc = "Search and replace in project",
      })
    end,
  },
}
