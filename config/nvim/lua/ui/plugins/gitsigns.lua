local M = {}

function M.get_pack_specs()
  return {
    {
      name = "gitsigns",
      src = "https://github.com/lewis6991/gitsigns.nvim",
      version = "31d6fb2d618bca1482b9f274751ead5f03461408",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local gitsigns = require("gitsigns")

  gitsigns.setup()

  M.setup_keymaps()
end

function M.setup_keymaps()
  local gitsigns = require("gitsigns")

  vim.keymap.set("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gitsigns.nav_hunk("prev")
    end
  end, {
    desc = "Previous hunk",
  })

  vim.keymap.set("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gitsigns.nav_hunk("next")
    end
  end, {
    desc = "Next hunk",
  })
end

return M
