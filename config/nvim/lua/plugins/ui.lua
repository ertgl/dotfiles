local function get_prompt_text(prompt, default_prompt)
  local prompt_text = prompt or default_prompt
  if prompt_text:sub(-1) == ":" then
    prompt_text = prompt_text:sub(1, -2)
  end
  prompt_text = " " .. prompt_text .. " "
  return prompt_text
end

local function override_ui_input()
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  local borders = require("config.borders")

  local border = borders.as_float_borders_array()

  ---@diagnostic disable-next-line: undefined-field
  local UIInput = Input:extend("UIInput")

  function UIInput:init(opts, on_done)
    local border_top_text = get_prompt_text(opts.prompt, "Input")
    local default_value = tostring(opts.default or "")

    UIInput.super.init(self, {
      border = {
        style = border,
        text = {
          top = border_top_text,
          top_align = "left",
        },
      },
      buf_options = {
        buftype = "prompt",
      },
      position = {
        col = 0,
        row = 1,
      },
      relative = "cursor",
      size = {
        width = math.max(40, vim.api.nvim_strwidth(default_value)),
      },
      win_options = {
        winhighlight = "NormalFloat:Normal,FloatBorder:Normal",
      },
    }, {
      default_value = default_value,
      on_close = function()
        on_done(nil)
      end,
      on_submit = function(value)
        on_done(value)
      end,
    })

    self:on(event.BufLeave, function()
      on_done(nil)
    end, { once = true })

    self:map("n", "<Esc>", function()
      on_done(nil)
    end, { noremap = true, nowait = true })
  end

  local input_ui = nil

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.input = function(opts, on_confirm)
    assert(type(on_confirm) == "function", "missing on_confirm function")

    if input_ui then
      return
    end

    input_ui = UIInput(opts, function(value)
      if input_ui then
        input_ui:unmount()
      end
      on_confirm(value)
      input_ui = nil
    end)

    input_ui:mount()
  end
end

return {
  {
    "MunifTanjim/nui.nvim",
    enabled = false,
    cond = not (vim.g.nvcat or vim.g.vscode),
    lazy = false,
    priority = math.huge,
    config = function()
      override_ui_input()
    end,
  },
}
