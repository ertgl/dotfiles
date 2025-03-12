local treesitter_ensure_installed = {
  "astro",
  "bash",
  "c",
  "cpp",
  "css",
  "csv",
  "dockerfile",
  "editorconfig",
  "elixir",
  "erlang",
  "fish",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "gomod",
  "gosum",
  "graphql",
  "hcl",
  "heex",
  "html",
  "htmldjango",
  "ini",
  "javascript",
  "jq",
  "jsdoc",
  "json",
  "json5",
  "jsonc",
  "lua",
  "luap",
  "make",
  "markdown",
  "markdown_inline",
  "nginx",
  "po",
  "properties",
  "proto",
  "python",
  "regex",
  "requirements",
  "robots",
  "rust",
  "sql",
  "tmux",
  "toml",
  "typescript",
  "xml",
  "yaml",
  "zig",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    cond = not vim.g.vscode,
    lazy = false,
    build = function()
      local treesitter_install = require("nvim-treesitter.install")

      treesitter_install.prefer_git = true

      local update_treesitter_parsers = treesitter_install.update({
        with_sync = true,
      })

      update_treesitter_parsers()
    end,
    config = function()
      local treesitter = require("nvim-treesitter")
      local treesitter_configs = require("nvim-treesitter.configs")

      if not vim.g.nvcat then
        local treesitter_install = require("nvim-treesitter.install")

        treesitter_install.prefer_git = true
      end

      treesitter_configs.setup({
        auto_install = true,
        ---@diagnostic disable-next-line: unused-local
        disable = function(lang, buf)
          local max_filesize = 1024 * 200
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        ensure_installed = treesitter_ensure_installed,
        highlight = {
          enabled = true,
          additional_vim_regex_highlighting = false,
        },
        ignore_install = {},
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enabled = true,
        },
        modules = {},
        sync_install = true,
      })

      require("nvim-treesitter.query_predicates")

      treesitter.setup()

      vim.treesitter.language.register("bash", "tmux")
      vim.treesitter.language.register("python", "spec")

      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldlevelstart = 99
      vim.o.foldmethod = "expr"

      vim.cmd([[
        TSEnable incremental_selection
        TSEnable indent
        TSEnable highlight
      ]])
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    cond = not vim.g.vscode,
  },

  {
    "davidmh/mdx.nvim",
    cond = not vim.g.vscode,
    opts = {},
  },
}
