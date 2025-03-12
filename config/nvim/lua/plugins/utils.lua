---@module "snacks"

return {
  {
    "nvim-lua/plenary.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    lazy = false,
    priority = math.huge,
  },

  {
    "folke/snacks.nvim",
    enabled = false,
    cond = not (vim.g.nvcat or vim.g.vscode),
    lazy = false,
    priority = math.huge,
    opts = function(_, opts)
      local borders = require("config.borders")

      local border = borders.as_float_borders_array()

      ---@type snacks.Config
      local config = {
        input = {
          enabled = true,
          icon = "",
          win = {
            border = border,
            relative = "cursor",
          },
        },
        layout = {
          layout = {
            border = border,
            height = 0.9,
            width = 0.9,
            zindex = 50,
          },
        },
        picker = {
          enabled = true,
          layout = "default",
          layouts = {
            default = {
              layout = {
                backdrop = false,
                border = "none",
                box = "horizontal",
                height = 0.9,
                width = 0.9,
                {
                  box = "vertical",
                  {
                    border = border,
                    height = 1,
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                    win = "input",
                  },
                  {
                    border = border,
                    title = " Results ",
                    title_pos = "center",
                    win = "list",
                  },
                },
                {
                  border = border,
                  title = "{preview:Preview}",
                  title_pos = "center",
                  width = 0.5,
                  win = "preview",
                },
              },
            },
          },
        },
      }

      return vim.tbl_deep_extend("force", opts or {}, config)
    end,
  },
}
