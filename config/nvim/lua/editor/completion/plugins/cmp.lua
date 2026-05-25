local M = {}

function M.get_pack_specs()
  return {
    {
      name = "cmp",
      src = "https://github.com/hrsh7th/nvim-cmp",
      version = "da88697d7f45d16852c6b2769dc52387d1ddc45f",
    },
    {
      name = "cmp-nvim-lsp-signature-help",
      src = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
      version = "fd3e882e56956675c620898bf1ffcf4fcbe7ec84",
    },
    {
      name = "cmp-nvim-lsp",
      src = "https://github.com/hrsh7th/cmp-nvim-lsp",
      version = "cbc7b02bb99fae35cb42f514762b89b5126651ef",
    },
    {
      name = "cmp-buffer",
      src = "https://github.com/hrsh7th/cmp-buffer",
      version = "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
    },
    {
      name = "cmp-path",
      src = "https://github.com/hrsh7th/cmp-path",
      version = "c642487086dbd9a93160e1679a1327be111cbc25",
    },
    {
      name = "cmp-treesitter",
      src = "https://github.com/ray-x/cmp-treesitter",
      version = "958fcfa0d8ce46d215e19cc3992c542f576c4123",
    },
    {
      name = "cmp_luasnip",
      src = "https://github.com/saadparwaiz1/cmp_luasnip",
      version = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90",
    },
    {
      name = "cmp-nvim-lsp-document-symbol",
      src = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol",
      version = "f94f7ba948e32cd302caba1c2ca3f7c697fb4fcf",
    },
    {
      name = "cmp-cmdline",
      src = "https://github.com/hrsh7th/cmp-cmdline",
      version = "d126061b624e0af6c3a556428712dd4d4194ec6d",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local luasnip = require("luasnip")

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
end

return M
