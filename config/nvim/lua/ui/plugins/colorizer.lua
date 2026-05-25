local M = {}

function M.get_pack_specs()
  return {
    {
      name = "colorizer",
      src = "https://github.com/catgoose/nvim-colorizer.lua",
      version = "85a5e83cd4daa258cf95c3204e277991d6fbe747",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local colorizer = require("colorizer")

  colorizer.setup({
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
  })
end

return M
