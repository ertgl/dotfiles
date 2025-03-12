return {
  {
    "catgoose/nvim-colorizer.lua",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VeryLazy",
    opts = {
      filetypes = {
        "*",
        css = {
          css = true,
          css_fn = true,
        },
      },
      lazy_load = true,
      user_default_options = {
        RGB = true,
        RGBA = true,
        RRGGBB = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        mode = "virtualtext",
        names = false,
        names_opts = {},
        sass = {
          enable = true,
          parsers = {
            "css",
          },
        },
        tailwind = "both",
        tailwind_opts = {
          update_names = true,
        },
        virtualtext = "■",
        virtualtext_inline = "before",
        virtualtext_mode = "foreground",
      },
    },
  },
}
