local M = {}

function M.setup()
  M.setup_for_general()
  M.setup_for_messages()
  M.setup_for_editor()
  M.setup_for_buffers()
  M.setup_for_lsp()
  M.setup_for_diagnostics()
  M.setup_for_help()
end

function M.setup_for_general()
  vim.keymap.set({ "n", "o", "x" }, "<c-c>", "<cmd>close<cr>", {
    desc = "Close",
  })

  if vim.g.vscode then
    return
  end

  vim.keymap.set({ "n", "o", "x" }, "<c-q>", "<cmd>quitall<cr>", {
    desc = "Quit all",
  })
end

function M.setup_for_messages()
  vim.keymap.set({ "n" }, "<leader>mmC", "<cmd>messages clear<CR>", {
    desc = "Clear message history",
  })

  vim.keymap.set({ "n", "o", "x" }, "<leader>mml", "<cmd>messages<CR>", {
    desc = "List messages",
  })
end

function M.setup_for_editor()
  vim.keymap.set({ "i", "n", "o", "x" }, "<c-s>", "<cmd>w<cr>", {
    desc = "Save file",
  })

  if vim.g.vscode then
    return
  end

  vim.keymap.set({ "i" }, "<S-Tab>", "<cmd><<cr>", {
    desc = "Shift left",
  })
end

function M.setup_for_buffers()
  vim.keymap.set({ "n" }, "<leader>bd", "<cmd>bd<cr>", {
    desc = "Delete the current buffer",
  })

  vim.keymap.set({ "n" }, "<leader>bD", "<cmd>bd!<cr>", {
    desc = "Delete the current buffer (Ignore changes)",
  })

  vim.keymap.set({ "n" }, "<leader>bq", "<cmd>%bd<cr>", {
    desc = "Delete all buffers",
  })

  vim.keymap.set({ "n" }, "<leader>bQ", "<cmd>%bd!<cr>", {
    desc = "Delete all buffers (Ignore changes)",
  })
end

function M.setup_for_lsp()
  if vim.g.vscode then
    return
  end

  vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", {
    buffer = true,
    desc = "Rename",
  })

  vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", {
    buffer = true,
    desc = "Code actions",
  })

  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", {
    buffer = true,
    desc = "Go to declaration",
  })

  vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {
    buffer = true,
    desc = "Show signature help",
  })

  vim.keymap.set("n", "H", "<cmd>lua vim.lsp.buf.hover()<cr>", {
    buffer = true,
    desc = "Show hover",
  })
end

function M.setup_for_diagnostics()
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
  end, {
    desc = "Go to previous diagnostic",
  })

  vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
  end, {
    desc = "Go to next diagnostic",
  })

  if vim.g.vscode then
    return
  end

  vim.keymap.set("n", "g?", "<cmd>lua vim.diagnostic.open_float()<cr>", {
    desc = "Open diagnostic float",
  })
end

function M.setup_for_help()
  vim.keymap.set({ "n" }, "<leader>hC", "<cmd>checkhealth<CR>", {
    desc = "Check health",
  })
end

return M
