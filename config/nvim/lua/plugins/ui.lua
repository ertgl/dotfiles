return {
  {
    "stevearc/dressing.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    priority = math.huge,
    config = function()
      local dressing = require("dressing")

      dressing.setup({
        input = {
          default_prompt = "Input",
          enabled = true,
          trim_prompt = true,
        },
      })
    end,
  },

  {
    "MunifTanjim/nui.nvim",
    enabled = false,
    cond = not (vim.g.nvcat or vim.g.vscode),
    priority = math.huge,
  },
}
