local M = {}

function M.get_pack_specs()
  return {
    {
      name = "lazydev",
      src = "https://github.com/folke/lazydev.nvim",
      version = "ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d",
    },
    {
      name = "luvit-meta",
      src = "https://github.com/Bilal2453/luvit-meta",
      version = "7edcd52ac6f2acc2f83f0cc27ac989a142408fbf",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local lazydev = require("lazydev")

  lazydev.setup({
    library = {
      {
        path = "luvit-meta/library",
        words = {
          "vim%.loop",
          "vim%.uv",
        },
      },
    },
  })
end

return M
