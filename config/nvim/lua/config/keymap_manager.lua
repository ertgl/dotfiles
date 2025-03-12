local M = {}

M.setup = function()
  M.setup_buffer_keymaps()
  M.setup_editor_keymaps()
  M.setup_help_keymaps()
  M.setup_general_keymaps()
  M.setup_notification_keymaps()
end

M.setup_buffer_keymaps = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

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

M.setup_editor_keymaps = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  vim.keymap.set({ "i", "n", "o", "x" }, "<c-s>", "<cmd>w<cr>", {
    desc = "Write file",
  })

  vim.keymap.set({ "i" }, "<S-Tab>", "<cmd><<cr>", {
    desc = "Shift left",
  })
end

M.setup_help_keymaps = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  vim.keymap.set({ "n" }, "<leader>hC", "<cmd>checkhealth<CR>", {
    desc = "Check health",
  })
end

M.setup_general_keymaps = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  vim.keymap.set({ "n", "o", "x" }, "<c-c>", "<cmd>close<cr>", {
    desc = "Close",
  })

  vim.keymap.set({ "n", "o", "x" }, "<c-q>", "<cmd>quitall<cr>", {
    desc = "Quit all",
  })
end

M.setup_notification_keymaps = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  vim.keymap.set({ "n" }, "<leader>nC", "<cmd>messages clear<CR>", {
    desc = "Clear notification history",
  })

  vim.keymap.set({ "n", "o", "x" }, "<leader>nl", "<cmd>messages<CR>", {
    desc = "List messages",
  })
end

return M
