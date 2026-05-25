local M = {}

function M.detect_client_capabilities()
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

function M.get_client_capabilities()
  local capabilities = M.detect_client_capabilities()

  M.override_client_capabilities(capabilities)

  return capabilities
end

function M.override_client_capabilities(capabilities)
  capabilities.workspace = capabilities.workspace or {}
  capabilities.workspace.didChangeWatchedFiles = capabilities.workspace.didChangeWatchedFiles or {}
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
end

return M
