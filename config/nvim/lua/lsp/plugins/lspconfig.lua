local M = {}

function M.get_pack_specs()
  return {
    {
      name = "lspconfig",
      src = "https://github.com/neovim/nvim-lspconfig",
      version = "43ed3797b266e1ee8d222e491379ad471c9d3146",
    },
  }
end

function M.setup() end

return M
