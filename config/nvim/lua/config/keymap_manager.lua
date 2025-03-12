local M = {}

M.setup = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  vim.keymap.set({ "n", "o", "x" }, "<c-c>", "<cmd>close<cr>", {
    desc = "Close",
  })

  vim.keymap.set({ "n", "o", "x" }, "<c-q>", "<cmd>quitall<cr>", {
    desc = "Quit all",
  })

  vim.keymap.set({ "i", "n", "o", "x" }, "<c-s>", "<cmd>w<cr>", {
    desc = "Write file",
  })

  vim.keymap.set({ "i" }, "<S-Tab>", "<cmd><<cr>", {
    desc = "Shift left",
  })

  vim.keymap.set({ "n" }, "<leader>bd", "<cmd>bd<cr>", {
    desc = "Delete the current buffer",
  })

  vim.keymap.set({ "n" }, "<leader>bD", "<cmd>%bd<cr>", {
    desc = "Delete all buffers",
  })

  vim.keymap.set({ "n" }, "<leader>hC", "<cmd>checkhealth<CR>", {
    desc = "Check health",
  })

  vim.keymap.set({ "n" }, "<leader>nC", "<cmd>messages clear<CR>", {
    desc = "Clear notification history",
  })

  vim.keymap.set({ "n", "o", "x" }, "<leader>nl", "<cmd>messages<CR>", {
    desc = "List messages",
  })
end

return M
