return {
  {
    "ellisonleao/gruvbox.nvim",
    cond = not vim.g.vscode,
    lazy = false,
    priority = math.huge,
    config = function()
      local gruvbox = require("gruvbox")

      gruvbox.setup({
        contrast = "hard",
        dim_inactive = false,
        italic = {
          comments = true,
          emphasis = true,
          folds = false,
          operators = false,
          strings = false,
        },
        overrides = {
          Directory = { link = "GruvboxFg1" } and { bold = true },
          TelescopeBorder = { link = "GruvboxFg2" },
          TelescopeEntryPrefix = { link = "GruvboxBg1" },
          TelescopeMatching = { link = "GruvboxYellow" },
          TelescopeMultiIcon = { link = "GruvboxPurple" },
          TelescopeMultiSelection = { link = "GruvboxPurple" },
          TelescopePreviewNormal = { link = "GruvboxFg1" },
          TelescopePromptPrefix = {},
          TelescopeResultsNormal = { link = "GruvboxFg1" },
          TelescopeSelection = { link = "GruvboxAqua" },
          TelescopeSelectionCaret = { link = "GruvboxAquaSign" },
          Title = { link = "GruvBoxFg3" },
          WhichKeyBorder = { link = "GruvboxBg2" },
          WhichKeyDesc = { link = "GruvboxFg1" },
          WhichKeyNormal = { link = "GruvboxFg2" },
          WhichKeyGroup = { link = "GruvboxAqua" },
          WhichKeySeparator = { link = "GruvboxBg2" },
        },
        terminal_colors = true,
        transparent_mode = true,
      })
    end,
    init = function()
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
