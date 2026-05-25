local M = {}

function M.detect_client_capabilities()
  if vim.g.vscode then
    return {}
  end

  local cmp_lsp = nil
  if not vim.g.vscode then
    cmp_lsp = require("cmp_nvim_lsp")
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  if cmp_lsp then
    capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
  end

  return capabilities
end

return M
