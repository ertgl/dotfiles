local M = {}

function M.get_pack_specs()
  return {
    {
      name = "nvim-surround",
      src = "https://github.com/kylechui/nvim-surround",
      version = "61319d4bd1c5e336e197defa15bd104c51f0fb29",
    },
  }
end

function M.setup()
  local surround = require("nvim-surround")

  surround.setup({})
end

return M
