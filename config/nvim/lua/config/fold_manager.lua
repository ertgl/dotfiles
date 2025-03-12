local M = {}

M.setup = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  M.setup_autocmd_lsp_attach()
  M.setup_autocmd_lsp_detach()
end

M.setup_autocmd_lsp_attach = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      local win = vim.api.nvim_get_current_win()
      if client and client:supports_method("textDocument/foldingRange") then
        M.switch_to_lsp(win)
      else
        M.switch_to_treesitter(win)
      end
    end,
  })
end

M.setup_autocmd_lsp_detach = function()
  vim.api.nvim_create_autocmd("LspDetach", {
    ---@diagnostic disable-next-line: unused-local
    callback = function(event)
      local win = vim.api.nvim_get_current_win()
      M.switch_to_treesitter(win)
    end,
  })
end

---@param win? number
M.switch_to_lsp = function(win)
  win = win or vim.api.nvim_get_current_win()
  if not vim.wo[win] then
    return
  end
  if not vim.wo[win][0] then
    return
  end
  vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
  vim.wo[win][0].foldmethod = "expr"
end

---@param win? number
M.switch_to_treesitter = function(win)
  win = win or vim.api.nvim_get_current_win()
  if not vim.wo[win] then
    return
  end
  if not vim.wo[win][0] then
    return
  end
  vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo[win][0].foldmethod = "expr"
end

return M
