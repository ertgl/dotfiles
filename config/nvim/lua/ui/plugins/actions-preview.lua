local M = {}

function M.get_pack_specs()
  return {
    {
      name = "actions-preview",
      src = "https://github.com/aznhe21/actions-preview.nvim",
      version = "cb938c25edaac38d362555f19244a9cb85d561e8",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local actions_preview = require("actions-preview")
  local actions_preview_highlight = require("actions-preview.highlight")
  local telescope_themes = require("telescope.themes")

  local borders = require("ui.borders")

  actions_preview.setup({
    backends = {
      "telescope",
    },
    highlight_command = {
      actions_preview_highlight.delta("delta"),
    },
    telescope = telescope_themes.get_dropdown({
      border = true,
      borderchars = {
        borders.top,
        borders.right,
        borders.bottom,
        borders.left,
        borders.top_left,
        borders.top_right,
        borders.bottom_right,
        borders.bottom_left,
      },
      layout_strategy = "vertical",
      layout_config = {
        height = 0.9,
        prompt_position = "top",
        width = 0.9,
      },
    }),
  })

  M.setup_keymaps()
end

function M.setup_keymaps()
  local actions_preview = require("actions-preview")

  vim.keymap.set("n", "ga", actions_preview.code_actions, {
    desc = "Code actions",
  })
end

return M
