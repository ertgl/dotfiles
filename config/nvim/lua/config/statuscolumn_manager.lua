local M = {}

---@param total_line_count? number
---@param visible_line_count? number
---@return string
M.generate_statuscolumn = function(total_line_count, visible_line_count)
  total_line_count = total_line_count or 1
  visible_line_count = visible_line_count or total_line_count
  return "%s %" .. #tostring(total_line_count) .. "{v:lnum} │ %" .. #tostring(visible_line_count) .. "{v:relnum} %C"
end

---@param bufnr? number
---@param loaded? boolean
---@return string
M.generate_statuscolumn_for_buffer = function(bufnr, loaded)
  bufnr = bufnr or 0
  loaded = loaded or false
  if not (loaded or vim.api.nvim_buf_is_loaded(bufnr)) then
    return ""
  end
  local total_line_count = vim.api.nvim_buf_line_count(bufnr)
  local first_visible_line_number = vim.fn.line("w0")
  local last_visible_line_number = vim.fn.line("w$")
  local visible_line_count = last_visible_line_number - first_visible_line_number + 1
  return M.generate_statuscolumn(total_line_count, visible_line_count)
end

---@param bufnr? number
---@param loaded? boolean
M.hide_statuscolumn_for_buffer = function(bufnr, loaded)
  bufnr = bufnr or 0
  loaded = loaded or false
  if not (loaded or vim.api.nvim_buf_is_loaded(bufnr)) then
    return
  end
  vim.o.statuscolumn = ""
end

---@param bufnr? number
---@param loaded? boolean
M.format_statuscolumn_for_buffer = function(bufnr, loaded)
  bufnr = bufnr or 0
  loaded = loaded or false
  if not (loaded or vim.api.nvim_buf_is_loaded(bufnr)) then
    return
  end
  vim.o.statuscolumn = M.generate_statuscolumn_for_buffer(bufnr, true)
end

---@param bufnr? number
M.maybe_format_statuscolumn_for_buffer = function(bufnr)
  local filetype_manager = require("config.filetype_manager")

  local popup_filetypes = filetype_manager.get_popup_filetypes()

  bufnr = bufnr or vim.fn.bufnr()
  if bufnr == -1 then
    return
  end

  local buffer = vim.bo[bufnr]
  if not buffer then
    return
  end

  if buffer.buftype == "nofile" or buffer.buftype == "prompt" or vim.tbl_contains(popup_filetypes, buffer.filetype) then
    M.hide_statuscolumn_for_buffer(bufnr, true)
    return
  end

  M.format_statuscolumn_for_buffer(bufnr, true)
end

M.setup = function()
  M.maybe_format_statuscolumn_for_buffer()

  M.setup_cmd()
  M.setup_autocmd()
end

M.setup_cmd = function()
  if vim.g.nvcat then
    return
  end

  vim.api.nvim_create_user_command("FormatStatuscolumn", function()
    M.maybe_format_statuscolumn_for_buffer()
  end, {
    bang = false,
    desc = "Reset statuscolumn for current buffer",
    nargs = 0,
  })
end

M.setup_autocmd = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  vim.api.nvim_create_autocmd({
    "BufEnter",
    "TextChanged",
    "TextChangedI",
  }, {
    ---@param ctx? table
    callback = function(ctx)
      ctx = ctx or {}
      M.maybe_format_statuscolumn_for_buffer(ctx.buf)
    end,
    pattern = "*",
  })
end

return M
