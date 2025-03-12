return {
  {
    "mfussenegger/nvim-lint",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "BufEnter",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        ["*"] = { "editorconfig-checker" },
        bash = { "shellcheck" },
        css = { "stylelint" },
        javascript = {},
        javascriptreact = {},
        python = { "dmypy" },
        rust = { "clippy" },
        scss = { "stylelint" },
        typescript = {},
        typescriptreact = {},
      }

      vim.env.ESLINT_D_PPID = vim.fn.getpid()

      if not vim.g.disable_linter_eslint_d then
        table.insert(lint.linters_by_ft["javascript"], "eslint_d")
        table.insert(lint.linters_by_ft["javascriptreact"], "eslint_d")
        table.insert(lint.linters_by_ft["typescript"], "eslint_d")
        table.insert(lint.linters_by_ft["typescriptreact"], "eslint_d")
      end

      if not vim.g.disable_linter_ruff then
        table.insert(lint.linters_by_ft["python"], "ruff")
      end

      local debouncer = vim.uv.new_timer()

      vim.api.nvim_create_autocmd({
        "TextChanged",
        "TextChangedI",
      }, {
        callback = function(ctx)
          debouncer:stop()
          debouncer:start(
            750,
            0,
            vim.schedule_wrap(function()
              lint.try_lint(nil, {
                cwd = vim.fn.getcwd(),
                -- ignore_errors = ctx.event == "TextChangedI",
              })
            end)
          )
        end,
      })

      vim.api.nvim_create_autocmd({
        "BufEnter",
        "InsertLeave",
      }, {
        callback = function()
          debouncer:stop()
          debouncer:start(
            50,
            0,
            vim.schedule_wrap(function()
              lint.try_lint(nil, {
                cwd = vim.fn.getcwd(),
              })
            end)
          )
        end,
      })
    end,
  },
}
