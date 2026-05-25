local M = {}

function M.get_pack_specs()
  return {
    {
      name = "fidget",
      src = "https://github.com/j-hui/fidget.nvim",
      version = "7fa433a83118a70fe24c1ce88d5f0bd3453c0970",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local fidget = require("fidget")
  local telescope = require("telescope")

  fidget.setup({
    notification = {
      filter = vim.log.levels.INFO,
      override_vim_notify = true,
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

  M.setup_keymaps()
end

function M.setup_keymaps()
  vim.keymap.set({ "n" }, "<leader>mmC", "<cmd>Fidget clear_history<CR>", {
    desc = "Clear message history",
  })

  vim.keymap.set({ "n", "o", "x" }, "<leader>mml", "<cmd>Fidget history<CR>", {
    desc = "List messages",
  })
end

return M
