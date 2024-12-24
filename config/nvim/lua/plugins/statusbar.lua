return {
  {
    "nvim-lualine/lualine.nvim",
    cond = not vim.g.nvcat and not vim.g.vscode,
    event = "VimEnter",
    priority = 14000,
    config = function()
      local lualine = require("lualine")
      local trouble = require("trouble")

      local get_reg_recording = function()
        local reg_recording = vim.fn.reg_recording()
        if reg_recording ~= "" then
          return "Recording @" .. reg_recording
        end
        return ""
      end

      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_d_normal",
      })

      lualine.setup({
        options = {
          component_separators = { left = " ", right = " " },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          globalstatus = false,
          icons_enabled = false,
          section_separators = { left = " ", right = " " },
          theme = "auto",
        },
        globalstatus = false,
        inactive_sections = {
          lualine_a = {
            {
              "mode",
            },
            {
              "macro",
              draw_empty = false,
              fmt = get_reg_recording,
            },
          },
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              file_status = true,
            },
          },
          lualine_x = {},
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
            },
            {
              "macro",
              draw_empty = false,
              fmt = get_reg_recording,
            },
          },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              file_status = true,
            },
          },
          lualine_d = {
            {
              symbols.get,
              cond = symbols.has,
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })

      vim.cmd([[
        augroup  lualine_color_scheme
        autocmd! ColorScheme * lua require("lualine").refresh()
        augroup END
      ]])
    end,
  },
}
