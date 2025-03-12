return {
  {
    "echasnovski/mini.indentscope",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufEnter",
    config = function()
      local mini_indentscope = require("mini.indentscope")

      mini_indentscope.setup({
        animation = mini_indentscope.gen_animation.none(),

        delay = 0,

        mappings = {
          object_scope = "ii",
          object_scope_with_border = "ai",

          goto_top = "[i",
          goto_bottom = "]i",
        },

        predicate = function(scope)
          return not scope.body.is_incomplete
        end,

        -- symbol = "¦",
        symbol = "·",
      })
    end,
  },
}
