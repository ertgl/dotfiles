return {
  {
    "folke/trouble.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VeryLazy",
    opts = {
      icons = {
        indent = {
          middle = " ",
          last = " ",
          top = " ",
          ws = "│  ",
        },
      },
      modes = {
        diagnostics = {
          groups = {
            { "filename", format = "{file_icon} {basename:Title} {count}" },
          },
        },
        test = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer diagnostics",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "All diagnostics",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle<cr>",
        desc = "LSP definitions & references",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location list",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix list",
      },
    },
  },

  {
    "dgagn/diagflow.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
      placement = "top",
      scope = "line",
      toggle_event = {
        "InsertEnter",
        "InsertLeave",
      },
      update_event = {
        "BufReadPost",
        "DiagnosticChanged",
      },
    },
  },
}
