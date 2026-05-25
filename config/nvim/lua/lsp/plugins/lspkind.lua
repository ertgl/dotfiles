local M = {}

function M.get_pack_specs()
  return {
    {
      name = "lspkind",
      src = "https://github.com/onsails/lspkind.nvim",
      version = "c7274c48137396526b59d86232eabcdc7fed8a32",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local lspkind = require("lspkind")

  lspkind.init({
    mode = "symbol_text",
    preset = "codicons",
  })
end

return M
