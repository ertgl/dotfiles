return {
  {
    "nvim-lualine/lualine.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
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
        filter = {
          range = true,
        },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_d_normal",
      })

      lualine.setup({
        options = {
          always_show_tabline = false,
          component_separators = {
            left = " ",
            right = " ",
          },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          globalstatus = false,
          icons_enabled = false,
          refresh = {
            events = {
              "BufEnter",
              "BufWritePost",
              "CursorMoved",
              "CursorMovedI",
              "Filetype",
              "FileChangedShellPost",
              "ModeChanged",
              "SessionLoadPost",
              "VimResized",
              "WinEnter",
            },
            statusline = 150,
            tabline = 200,
            winbar = 200,
          },
          section_separators = {
            left = " ",
            right = " ",
          },
          theme = "auto",
        },
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
          lualine_y = {
            "progress",
          },
          lualine_z = {
            "location",
          },
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
          lualine_b = {
            "branch",
            "diff",
            "diagnostics",
          },
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
              draw_empty = false,
            },
          },
          lualine_x = {
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = {
            "progress",
          },
          lualine_z = {
            "location",
          },
        },
      })

      vim.cmd([[
        augroup  lualine__color_scheme
        autocmd! ColorScheme * lua require("lualine").refresh()
        augroup END
      ]])
    end,
  },
}
