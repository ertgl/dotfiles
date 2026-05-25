local M = {}

---@param total_line_count? number
---@param visible_line_count? number
---@return string
function M.generate_statuscolumn(total_line_count, visible_line_count)
  total_line_count = total_line_count or 1
  visible_line_count = visible_line_count or total_line_count
  return "%s %" .. #tostring(total_line_count) .. "{v:lnum} │ %" .. #tostring(visible_line_count) .. "{v:relnum} %C"
end

---@param bufnr? number
---@param loaded? boolean
---@return string
function M.generate_statuscolumn_for_buffer(bufnr, loaded)
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
function M.hide_statuscolumn_for_buffer(bufnr, loaded)
  bufnr = bufnr or 0
  loaded = loaded or false
  if not (loaded or vim.api.nvim_buf_is_loaded(bufnr)) then
    return
  end
  vim.o.statuscolumn = ""
end

---@param bufnr? number
---@param loaded? boolean
function M.format_statuscolumn_for_buffer(bufnr, loaded)
  bufnr = bufnr or 0
  loaded = loaded or false
  if not (loaded or vim.api.nvim_buf_is_loaded(bufnr)) then
    return
  end
  vim.o.statuscolumn = M.generate_statuscolumn_for_buffer(bufnr, true)
end

---@param bufnr? number
function M.maybe_format_statuscolumn_for_buffer(bufnr)
  local file_types_module = require("core.file_types")

  bufnr = bufnr or vim.fn.bufnr()
  if bufnr == -1 then
    return
  end

  local buffer = vim.bo[bufnr]
  if not buffer then
    return
  end

  if (
        buffer.buftype == "nofile"
        or buffer.buftype == "prompt"
        or vim.tbl_contains(file_types_module.get_popup_file_types(), buffer.filetype)
      ) then
    M.hide_statuscolumn_for_buffer(bufnr, true)
    return
  end

  M.format_statuscolumn_for_buffer(bufnr, true)
end

function M.setup()
  M.maybe_format_statuscolumn_for_buffer()

  M.setup_cmd()
  M.setup_autocmd()
end

function M.setup_cmd()
  vim.api.nvim_create_user_command("FormatStatuscolumn", function()
    M.maybe_format_statuscolumn_for_buffer()
  end, {
    bang = false,
    desc = "Reset statuscolumn for the current buffer",
    nargs = 0,
  })
end

function M.setup_autocmd()
  if vim.g.vscode then
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
