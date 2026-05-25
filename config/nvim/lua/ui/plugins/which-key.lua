local M = {}

function M.get_pack_specs()
  return {
    {
      name = "which-key",
      src = "https://github.com/folke/which-key.nvim",
      version = "3aab2147e74890957785941f0c1ad87d0a44c15a",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local wk = require("which-key")

  local borders = require("ui.borders")

  local borders_array = borders.as_float_borders_array()

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
    sort = { "group", "alphanum", "icase" },
    win = {
      border = borders_array,
      noautocmd = false,
    },
  })

  wk.add({
    { "<leader>?", group = "key", proxy = "?" },
    { "<leader>[", group = "backward", proxy = "[" },
    { "<leader>]", group = "forward", proxy = "]" },
    { "<leader>b", group = "buffer", proxy = "b" },
    { "<leader>c", group = "change", proxy = "c" },
    { "<leader>f", group = "file", proxy = "f" },
    { "<leader>g", group = "goto", proxy = "g" },
    { "<leader>h", group = "help", proxy = "h" },
    { "<leader>j", group = "jump", proxy = "j" },
    { "<leader>m", group = "misc", proxy = "m" },
    { "<leader>mm", group = "message", proxy = "mm" },
    { "<leader>ms", group = "session", proxy = "ms" },
    { "<leader>p", group = "picker", proxy = "p" },
    { "<leader>s", group = "search", proxy = "s" },
    { "<leader>u", group = "undo", proxy = "u" },
    { "<leader>w", group = "window", proxy = "<c-w>" },
    { "<leader>v", group = "visual", proxy = "v" },
    { "<leader>z", group = "view", proxy = "z" },
  })

  M.setup_keymaps()
end

function M.setup_keymaps()
  local wk = require("which-key")

  vim.keymap.set({ "n" }, "<leader>?", function()
    wk.show({
      ["global"] = true,
      ["local"] = true,
    })
  end, {
    desc = "Show keys",
  })
end

return M
