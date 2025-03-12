---@diagnostic disable-next-line: undefined-global
local OS_FAMILY = ya.target_family()

local render_linemode = function(file)
  local perm_str = "----------"
  if OS_FAMILY == "unix" then
    local perm = file.cha:perm()
    if perm then
      perm_str = perm
    end
  end

  local time = math.floor(file.cha.mtime or 0)
  local time_str = ""
  if time == 0 then
    time_str = ""
  elseif os.date("%Y", time) == os.date("%Y") then
    ---@diagnostic disable-next-line: cast-local-type
    time_str = os.date("%b %d %H:%M", time)
  else
    ---@diagnostic disable-next-line: cast-local-type
    time_str = os.date("%b %d  %Y", time)
  end

  local size = file:size()
  ---@diagnostic disable-next-line: undefined-global
  local size_str = size and ya.readable_size(size) or "-"

  return string.format("%10s %8s %14s", perm_str, size_str, time_str)
end

local bind_linemode_renderer = function()
  ---@diagnostic disable-next-line: undefined-global
  function Linemode:custom()
    ---@diagnostic disable-next-line: undefined-global
    return render_linemode(self._file)
  end
end

local M = {
  ---@diagnostic disable-next-line: unused-local
  setup = function()
    bind_linemode_renderer()
  end,
}

return M
