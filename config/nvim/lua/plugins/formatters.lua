return {
  {
    "stevearc/conform.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufEnter",
    config = function()
      local conform = require("conform")

      conform.setup({
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = {},
        formatters_by_ft = {
          bash = { "shellcheck" },
          c = { "clang-format" },
          css = { "stylelint" },
          elixir = { "mix" },
          erlang = { "erlfmt" },
          go = { "gofmt" },
          javascript = { "eslint_d" },
          javascriptreact = { "eslint_d" },
          lua = { "stylua" },
          nginx = { "nginxfmt" },
          python = { "ruff_fix", "ruff_format" },
          rust = { "rustfmt" },
          scss = { "stylelint" },
          sh = { "shellcheck" },
          sql = { "sql_formatter" },
          toml = { "taplo" },
          typescript = { "eslint_d" },
          typescriptreact = { "eslint_d" },
          yaml = { "yamlfmt" },
          zig = { "zigfmt" },
        },
      })

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        conform.format({
          async = true,
          lsp_format = "fallback",
          range = range,
        })
      end, {
        range = true,
      })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}
