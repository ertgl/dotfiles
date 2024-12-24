return {
  {
    "ellisonleao/gruvbox.nvim",
    cond = not vim.g.vscode,
    lazy = false,
    priority = math.huge,
    config = function()
      local gruvbox = require("gruvbox")

      local float_border_link = "GruvboxBg4"

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
          -- ["@function.call"] = { link = "@text.strong" },
          -- ["@function.method.call"] = { link = "@text.strong" },
          -- ["@lsp.mod.defaultLibrary.typescript"] = { link = "GruvboxPurpleBold" },
          -- ["@lsp.type.class.typescript"] = { default = true },
          -- ["@lsp.type.interface.typescript"] = { link = "GruvboxYellowBold" },
          -- ["@lsp.typemod.class.defaultLibrary.typescript"] = { link = "GruvboxPurpleBold" },
          -- ["@lsp.typemod.member.defaultLibrary.typescript"] = { link = "@text.strong" },
          -- ["@operator.typescript"] = { link = "@constant" },
          -- ["@type.builtin.typescript"] = { link = "@keyword" },
          -- ["@type.typescript"] = { link = "@constant" },
          -- ["@variable.typescript"] = { link = "@constant" },
          Backdrop = { link = "GruvboxBg4" },
          Directory = { link = "GruvboxFg1" } and { bold = true },
          TelescopeBorder = { link = "GruvboxFg2" },
          TelescopeEntryPrefix = { link = "GruvboxBg1" },
          TelescopeMatching = { link = "GruvboxYellow" },
          TelescopeMultiIcon = { link = "GruvboxPurple" },
          TelescopeMultiSelection = { link = "GruvboxPurple" },
          TelescopePreviewBorder = { link = float_border_link },
          TelescopePreviewNormal = { link = "GruvboxFg1" },
          TelescopePromptBorder = { link = float_border_link },
          TelescopePromptPrefix = {},
          TelescopeResultsBorder = { link = float_border_link },
          TelescopeResultsNormal = { link = "GruvboxFg1" },
          TelescopeSelection = { link = "GruvboxAqua" },
          TelescopeSelectionCaret = { link = "GruvboxAquaSign" },
          Title = { link = "GruvBoxFg4" },
          WhichKeyBorder = { link = "GruvboxBg2" },
          WhichKeyDesc = { link = "GruvboxFg1" },
          WhichKeyNormal = { link = "GruvboxFg2" },
          WhichKeyGroup = { link = "GruvboxAqua" },
          WhichKeySeparator = { link = "GruvboxBg2" },
          YaziFloatBorder = { link = float_border_link },
        },
        terminal_colors = true,
        transparent_mode = true,
      })

      vim.cmd("colorscheme gruvbox")
    end,
  },
}
