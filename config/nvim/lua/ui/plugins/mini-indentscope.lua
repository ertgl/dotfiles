local M = {}

function M.get_pack_specs()
  return {
    {
      name = "mini.indentscope",
      src = "https://github.com/echasnovski/mini.indentscope",
      version = "92fbaf895f83c59575ec599df532b297ebf62b14",
    },
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

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
end

return M
