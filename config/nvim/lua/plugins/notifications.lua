return {
  {
    "j-hui/fidget.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    lazy = false,
    priority = 100000,
    config = function()
      local fidget = require("fidget")
      local telescope = require("telescope")

      fidget.setup({
        notification = {
          filter = vim.log.levels.INFO,
          override_vim_notify = false,
          view = {
            group_separator_hl = "Comment",
          },
          window = {
            normal_hl = "LineNr",
            winblend = 0,
          },
        },
      })

      telescope.load_extension("fidget")
    end,
  },
}
