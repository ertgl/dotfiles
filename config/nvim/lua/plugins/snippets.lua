return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VeryLazy",
    build = "make install_jsregexp",
    config = function()
      local luasnip = require("luasnip")
      local luasnip_vscode_like = require("luasnip.loaders.from_vscode")

      luasnip_vscode_like.lazy_load({
        paths = {
          "./snippets/vscode-like",
        },
      })

      vim.keymap.set({ "i" }, "<C-M-K>", function()
        luasnip.expand()
      end, {
        silent = true,
      })

      vim.keymap.set({ "i", "s" }, "<C-M-L>", function()
        luasnip.jump(1)
      end, {
        silent = true,
      })

      vim.keymap.set({ "i", "s" }, "<C-M-J>", function()
        luasnip.jump(-1)
      end, {
        silent = true,
      })

      vim.keymap.set({ "i", "s" }, "<C-M-E>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, {
        silent = true,
      })
    end,
  },
}
