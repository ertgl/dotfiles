return {
  {
    "ellisonleao/gruvbox.nvim",
    cond = not vim.g.vscode,
    lazy = false,
    priority = math.huge,
    config = function()
      local gruvbox = require("gruvbox")

      local border_link = "GruvboxBg2"
      local float_border_link = "GruvboxBg3"

      gruvbox.setup({
        contrast = "hard",
        dim_inactive = false,
        -- Set `inverse` to `false` to fix the background color of the statusline.
        -- https://github.com/nvim-lualine/lualine.nvim/issues/1312#issuecomment-2439965065
        inverse = false,
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
          ["@keyword.jsdoc"] = { link = "GruvboxAqua" },
          ["@lsp.type.interface"] = { link = "GruvboxYellow" },
          ["@lsp.type.type"] = { link = "GruvboxYellow" },
          ["@lsp.typemod.class.defaultLibrary"] = { link = "GruvboxPurpleBold" },
          ["@lsp.typemod.interface.defaultLibrary"] = { link = "GruvboxOrangeBold" },
          ["@lsp.typemod.type.declaration"] = { link = "GruvboxYellow" },
          ["@lsp.typemod.variable.readonly"] = { link = "GruvboxPurple" },
          ["@module.builtin"] = { link = "GruvboxPurpleBold" },
          ["@type"] = { link = "GruvboxPurple" },
          ["@type.builtin"] = { link = "GruvboxOrangeBold" },
          ["@type.jsdoc"] = { link = "GruvboxFg3" },
          ["@variable.builtin"] = { link = "GruvboxPurpleBold" },
          Backdrop = { link = "GruvboxBg4" },
          Directory = { link = "GruvboxFg1" } and { bold = true },
          TelescopeBorder = { link = border_link },
          TelescopeEntryPrefix = { link = "GruvboxBg1" },
          TelescopeMatching = { link = "GruvboxYellow" },
          TelescopeMultiIcon = { link = "GruvboxPurple" },
          TelescopeMultiSelection = { link = "GruvboxPurple" },
          TelescopePreviewBorder = { link = border_link },
          TelescopePreviewNormal = { link = "GruvboxFg3" },
          TelescopePromptBorder = { link = border_link },
          TelescopePromptCounter = { link = "GruvboxFg4" },
          TelescopePromptPrefix = {},
          TelescopeResultsBorder = { link = border_link },
          TelescopeResultsNormal = { link = "GruvboxFg2" },
          TelescopeSelection = { link = "GruvboxAqua" },
          TelescopeSelectionCaret = { link = "GruvboxAquaSign" },
          TelescopeTitle = { bg = "none" },
          TreesitterContextSeparator = { link = border_link },
          Title = { link = "GruvBoxFg3" },
          WhichKeyBorder = { link = float_border_link },
          WhichKeyDesc = { link = "GruvboxFg2" },
          WhichKeyNormal = { link = "GruvboxFg3" },
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
