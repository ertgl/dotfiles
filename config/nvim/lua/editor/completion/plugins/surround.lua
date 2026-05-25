local M = {}

function M.get_pack_specs()
  return {
    {
      name = "nvim-surround",
      src = "https://github.com/kylechui/nvim-surround",
      version = "8b47db616ef658b8fc27e61db2896aa2f40134de",
    },
  }
end

function M.setup()
  local surround = require("nvim-surround")

  surround.setup({})
end

return M
