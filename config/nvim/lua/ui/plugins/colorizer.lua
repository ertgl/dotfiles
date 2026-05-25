local M = {}

function M.get_pack_specs()
  return {
    {
      name = "colorizer",
      src = "https://github.com/catgoose/nvim-colorizer.lua",
      version = "72a05f62c52241bc7441c820eb53946f92b2e6a4",
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
