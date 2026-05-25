local M = {}

function M.get_pack_specs()
  return {
    {
      name = "grug-far",
      src = "https://github.com/MagicDuck/grug-far.nvim",
      version = "dc4684e163971bb1f5bfb93fbd4bb3e892bf9b15",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

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

  M.setup_keymaps()
end

function M.setup_keymaps()
  vim.keymap.set("n", "<Leader>sR", [[<cmd>GrugFar<cr>]], {
    desc = "Search and replace in project",
  })
end

return M
