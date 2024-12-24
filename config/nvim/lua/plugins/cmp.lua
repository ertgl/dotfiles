return {
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    cond = not vim.g.vscode,
    event = "BufRead",
  },

  {
    "hrsh7th/cmp-nvim-lsp",
    cond = not vim.g.vscode,
    event = "BufRead",
  },

  {
    "hrsh7th/cmp-buffer",
    cond = not vim.g.vscode,
    event = "BufRead",
  },

  {
    "hrsh7th/cmp-path",
    cond = not vim.g.vscode,
    event = "BufRead",
  },

  {
    "ray-x/cmp-treesitter",
    cond = not vim.g.vscode,
    event = "BufRead",
  },

  {
    "saadparwaiz1/cmp_luasnip",
    cond = not vim.g.vscode,
    event = "BufRead",
  },

  {
    "hrsh7th/cmp-cmdline",
    cond = not vim.g.vscode,
    event = "VimEnter",
    config = function()
      local cmp = require("cmp")

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {
            name = "buffer",
          },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          {
            name = "path",
          },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = {
                "Man",
                "!",
              },
            },
          },
        }),
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    cond = not vim.g.vscode,
    event = "VimEnter",
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local tailwind_tools_cmp = require("tailwind-tools.cmp")

      cmp.setup({
        formatting = {
          expandable_indicator = true,
          fields = {
            "abbr",
            "kind",
            "menu",
          },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            before = function(entry, vim_item)
              return tailwind_tools_cmp.lspkind_format(entry, vim_item)
            end,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),

          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),

          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
                })
              else
                cmp.abort()
                fallback()
              end
            end,
          }),
        }),
        preselect = "None",
        snippet = {
          expand = function(args)
            local luasnip = require("luasnip")

            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          {
            name = "nvim_lsp_signature_help",
          },
          {
            name = "nvim_lsp",
          },
          {
            name = "treesitter",
          },
          {
            name = "lazydev",
            group_index = 0,
          },
          {
            name = "path",
          },
          {
            name = "buffer",
          },
          {
            name = "luasnip",
            option = {
              show_autosnippets = true,
            },
          },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
