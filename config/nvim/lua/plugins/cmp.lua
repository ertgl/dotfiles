return {
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufRead",
  },

  {
    "hrsh7th/cmp-nvim-lsp",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufRead",
  },

  {
    "hrsh7th/cmp-buffer",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufRead",
  },

  {
    "hrsh7th/cmp-path",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufRead",
  },

  {
    "ray-x/cmp-treesitter",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufRead",
  },

  {
    "saadparwaiz1/cmp_luasnip",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufRead",
  },

  {
    "hrsh7th/nvim-cmp",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VimEnter",
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      local lspkind_format = lspkind.cmp_format({
        mode = "symbol_text",
      })

      cmp.setup({
        formatting = {
          expandable_indicator = true,
          fields = {
            "abbr",
            "kind",
            "menu",
          },
          format = function(entry, vim_item)
            vim_item.menu = entry.source.name
            if vim_item.menu == "nvim_lsp" then
              vim_item.menu = "LSP"
            elseif vim_item.menu == "nvim_lsp_signature_help" then
              vim_item.menu = "Signature"
            elseif vim_item.menu == "lazydev" then
              vim_item.menu = "Nvim"
            elseif vim_item.menu == "treesitter" then
              vim_item.menu = "Syntax"
            elseif vim_item.menu == "path" then
              vim_item.menu = "Path"
            elseif vim_item.menu == "buffer" then
              vim_item.menu = "Buffer"
            elseif vim_item.menu == "luasnip" then
              vim_item.menu = "VSCode"
            end
            vim_item = lspkind_format(entry, vim_item)
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete({
            reason = cmp.ContextReason.Manual,
          }),

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
          expand = function(params)
            local luasnip = require("luasnip")

            luasnip.lsp_expand(params.body)
          end,
        },
        sources = {
          {
            name = "nvim_lsp_signature_help",
            priority = 0,
          },
          {
            name = "nvim_lsp",
            priority = -100,
          },
          {
            name = "lazydev",
            group_index = 0,
            priority = -200,
          },
          {
            name = "treesitter",
            max_item_count = 10,
            priority = -300,
          },
          {
            name = "path",
            max_item_count = 10,
            priority = -400,
          },
          {
            name = "buffer",
            max_item_count = 5,
            priority = -500,
          },
          {
            name = "luasnip",
            max_item_count = 10,
            option = {
              show_autosnippets = true,
            },
            priority = -600,
          },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },

  {
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VimEnter",
  },

  {
    "hrsh7th/cmp-cmdline",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VimEnter",
    config = function()
      local cmp = require("cmp")

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp_document_symbol",
          },
          {
            name = "buffer",
          },
        }),
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
}
