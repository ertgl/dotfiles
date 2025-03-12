return {
  {
    "folke/which-key.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VeryLazy",
    priority = math.huge,
    config = function()
      local wk = require("which-key")
      local borders = require("config.borders")

      local border = borders.as_float_borders_array()

      wk.setup({
        delay = 0,
        icons = {
          breadcrumb = "→",
          keys = {
            BS = "<bs>",
            Esc = "<esc>",
          },
          mappings = false,
          separator = borders.left,
        },
        keys = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        plugins = {
          marks = true,
          presets = {
            g = true,
            motions = true,
            nav = true,
            operators = true,
            text_objects = true,
            windows = true,
            z = true,
          },
          registers = true,
          spelling = {
            enabled = false,
            suggestions = 20,
          },
        },
        preset = "helix",
        show_help = false,
        show_keys = true,
        sort = { "group", "alphanum" },
        win = {
          border = border,
          noautocmd = false,
        },
      })

      wk.add({
        { "<leader>?", group = "key", proxy = "?" },
        { "<leader>[", group = "backward", proxy = "[" },
        { "<leader>]", group = "forward", proxy = "]" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "change", proxy = "c" },
        { "<leader>cs", group = "surround", proxy = "cs" },
        { "<leader>cS", group = "surround with new line", proxy = "cS" },
        { "<leader>f", group = "file" },
        { "<leader>fm", group = "manager" },
        { "<leader>fp", group = "browser" },
        { "<leader>g", group = "goto", proxy = "g" },
        { "<leader>h", group = "help" },
        { "<leader>n", group = "notification" },
        { "<leader>j", group = "jump" },
        { "<leader>m", group = "misc" },
        { "<leader>ms", group = "session" },
        { "<leader>p", group = "picker" },
        { "<leader>s", group = "search" },
        { "<leader>sf", group = "flash" },
        { "<leader>u", group = "undo" },
        { "<leader>w", group = "window", proxy = "<c-w>" },
        { "<leader>x", group = "diagnostic" },
        { "<leader>z", group = "view", proxy = "z" },
      })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({
            global = true,
            ["local"] = true,
          })
        end,
        desc = "Show commands",
      },
    },
  },
}
