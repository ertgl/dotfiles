local M = {}

M.detect_capabilities = function()
  if vim.g.nvcat or vim.g.vscode then
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

M.disable_logging = function()
  vim.lsp.set_log_level(vim.log.levels.ERROR)
end

M.setup = function()
  M.disable_logging()
  M.setup_autocmd()
end

M.setup_autocmd = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      -- local client = vim.lsp.get_client_by_id(event.data.client_id)
      --
      -- if not client then
      --   return
      -- end
      --
      -- -- Disable LSP based syntax highlighting.
      -- client.server_capabilities.semanticTokensProvider = nil

      M.setup_keymaps()
    end,
  })
end

M.setup_keymaps = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  vim.keymap.set("n", "H", "<cmd>lua vim.lsp.buf.hover()<cr>", {
    buffer = true,
    desc = "Show hover",
  })

  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {
    buffer = true,
    desc = "Show hover",
  })

  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "Code actions" })
  vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, { desc = "Code actions" })

  -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", {
  --   buffer = true,
  --   desc = "Go to definition",
  -- })

  vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", {
    buffer = true,
    desc = "Go to definitions",
  })

  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", {
    buffer = true,
    desc = "Go to declaration",
  })

  -- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", {
  --   buffer = true,
  --   desc = "Go to implementation",
  -- })

  vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", {
    buffer = true,
    desc = "Go to implementation",
  })

  -- vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", {
  --   buffer = true,
  --   desc = "Go to type definition",
  -- })

  vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", {
    buffer = true,
    desc = "Go to type definitions",
  })

  -- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", {
  --   buffer = true,
  --   desc = "Go to references",
  -- })

  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {
    buffer = true,
    desc = "Go to references",
  })

  vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {
    buffer = true,
    desc = "Show signature help",
  })

  vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", {
    buffer = true,
    desc = "Rename",
  })

  vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", {
    buffer = true,
    desc = "Code actions",
  })

  vim.keymap.set("n", "gf", "<cmd>lua vim.diagnostic.open_float()<cr>", {
    buffer = true,
    desc = "Open diagnostic float",
  })

  vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", {
    buffer = true,
    desc = "Go to previous diagnostic",
  })

  vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", {
    buffer = true,
    desc = "Go to next diagnostic",
  })
end

return M
