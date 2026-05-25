local M = {}

function M.get_pack_specs()
  return {
    {
      name = "luasnip",
      src = "https://github.com/L3MON4D3/LuaSnip",
      version = "dae4f5aaa3574bd0c2b9dd20fb9542a02c10471c",
    },
  }
end

function M.setup_pack_autocmds()
  local handle_pack_changed = function(ev)
    if (
          ev.data.spec.name == "luasnip"
          and (ev.data.kind == "install" or ev.data.kind == "update")
        ) then
      vim.system(
        {
          "make",
          "install_jsregexp"
        },
        {
          cwd = ev.data.path
        }
      )
    end
  end

  vim.api.nvim_create_autocmd("PackChanged", {
    callback = handle_pack_changed
  })
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local luasnip_vscode = require("luasnip.loaders.from_vscode")

  luasnip_vscode.lazy_load({
    paths = {
      "./snippets/vscode",
    },
  })

  M.setup_keymaps()
end

function M.setup_keymaps()
  local luasnip = require("luasnip")

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
end

return M
