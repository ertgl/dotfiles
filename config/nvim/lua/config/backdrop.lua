-- Based on the following code:
-- https://github.com/nvim-telescope/telescope.nvim/issues/3020#issuecomment-2439446111
-- Modifications:
-- - Replaced the backdrop name.
-- - Replaced the hard-coded color with a link to a highlight group.
-- - Added support for multiple filetypes.

local M = {}

M.default_blend = 90

M.blend_by_filename = {
  TelescopePrompt = 90,
}

M.default_popup_zindex = 50

M.popup_zindex_by_filename = {}

M.setup = function()
  if vim.g.nvcat or vim.g.vscode then
    return
  end

  local filetype_manager = require("config.filetype_manager")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype_manager.get_popup_filetypes(),
    callback = function(ctx)
      local backdrop_name = "Backdrop"
      local backdrop_blend = M.blend_by_filename[ctx.file] or M.default_blend
      local popup_zindex = M.popup_zindex_by_filename[ctx.file] or M.default_popup_zindex

      local backdrop_bufnr = vim.api.nvim_create_buf(false, true)
      local winnr = vim.api.nvim_open_win(backdrop_bufnr, false, {
        border = "none",
        col = 0,
        focusable = false,
        height = vim.o.lines,
        relative = "editor",
        row = 0,
        style = "minimal",
        width = vim.o.columns,
        zindex = popup_zindex - 1,
      })

      vim.api.nvim_set_hl(0, backdrop_name, { link = "Backdrop", default = true })
      vim.wo[winnr].winhighlight = "Normal:" .. backdrop_name
      vim.wo[winnr].winblend = backdrop_blend
      vim.bo[backdrop_bufnr].buftype = "nofile"

      vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
        buffer = ctx.buf,
        once = true,
        callback = function()
          if vim.api.nvim_win_is_valid(winnr) then
            vim.api.nvim_win_close(winnr, true)
          end
          if vim.api.nvim_buf_is_valid(backdrop_bufnr) then
            vim.api.nvim_buf_delete(backdrop_bufnr, { force = true })
          end
        end,
      })
    end,
  })
end

return M
