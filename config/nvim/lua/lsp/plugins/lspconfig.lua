local M = {}

function M.get_pack_specs()
  return {
    {
      name = "lspconfig",
      src = "https://github.com/neovim/nvim-lspconfig",
      version = "702f69fb167e9119f14adc4dfd4fcadf4d1b07a0",
    },
  }
end

function M.setup()
end

return M
