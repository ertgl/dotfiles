return {
  {
    "ellisonleao/gruvbox.nvim",
    cond = not vim.g.vscode,
    lazy = false,
    priority = math.huge,
    config = function()
      local gruvbox = require("gruvbox")

      local border_link = "GruvboxFg1"
      local float_border_link = "GruvboxFg4"

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
          ["@function.builtin.lua"] = { link = "GruvboxYellow" },
          ["@function.call"] = { link = "@text.strong" },
          ["@function.method.call"] = { link = "@text.strong" },
          ["@function.method.call.lua"] = { link = "GruvboxGreen" },
          ["@keyword.export"] = { link = "GruvboxRed" },
          ["@lsp.type.interface"] = { link = "GruvboxYellow" },
          ["@lsp.type.type"] = { link = "GruvboxYellow" },
          ["@lsp.typemod.class.defaultLibrary"] = { link = "GruvboxPurpleBold" },
          ["@lsp.typemod.interface.defaultLibrary"] = { link = "GruvboxOrangeBold" },
          ["@lsp.typemod.type.declaration"] = { link = "GruvboxYellow" },
          ["@module.builtin"] = { link = "GruvboxPurpleBold" },
          ["@type"] = { link = "GruvboxPurple" },
          ["@type.builtin"] = { link = "GruvboxOrangeBold" },
          ["@variable.builtin"] = { link = "GruvboxPurpleBold" },
          Backdrop = { link = "GruvboxBg4" },
          Directory = { link = "GruvboxFg1" } and { bold = true },
          TelescopeBorder = { link = border_link },
          TelescopeEntryPrefix = { link = "GruvboxBg1" },
          TelescopeMatching = { link = "GruvboxYellow" },
          TelescopeMultiIcon = { link = "GruvboxPurple" },
          TelescopeMultiSelection = { link = "GruvboxPurple" },
          TelescopePreviewBorder = { link = border_link },
          TelescopePreviewNormal = { link = "GruvboxFg1" },
          TelescopePromptBorder = { link = border_link },
          TelescopePromptCounter = { link = "GruvboxFg3" },
          TelescopePromptPrefix = {},
          TelescopeResultsBorder = { link = border_link },
          TelescopeResultsNormal = { link = "GruvboxFg1" },
          TelescopeSelection = { link = "GruvboxAqua" },
          TelescopeSelectionCaret = { link = "GruvboxAquaSign" },
          TelescopeTitle = { bg = "none" },
          Title = { link = "GruvBoxFg4" },
          WhichKeyBorder = { link = float_border_link },
          WhichKeyDesc = { link = "GruvboxFg1" },
          WhichKeyNormal = { link = "GruvboxFg1" },
          WhichKeyGroup = { link = "GruvboxAqua" },
          WhichKeySeparator = { link = float_border_link },
          YaziFloatBorder = { link = border_link },
        },
        terminal_colors = true,
        transparent_mode = true,
      })

      vim.cmd("colorscheme gruvbox")
    end,
  },
}
