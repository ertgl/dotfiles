local git = require("git")
local mime_ext_local = require("mime-ext.local")
local session = require("session")

local boundary = require("boundary")
local linemode = require("linemode")

session:setup({
  sync_yanked = true,
})

---@diagnostic disable-next-line: undefined-global
th.git = th.git or {}
---@diagnostic disable-next-line: undefined-global
th.git.added_sign = "A"
---@diagnostic disable-next-line: undefined-global
th.git.deleted_sign = "D"
---@diagnostic disable-next-line: undefined-global
th.git.ignored_sign = "I"
---@diagnostic disable-next-line: undefined-global
th.git.modified_sign = "M"
---@diagnostic disable-next-line: undefined-global
th.git.updated_sign = "U"
---@diagnostic disable-next-line: undefined-global
th.git.untracked_sign = "?"

git:setup({
  order = -math.huge,
})

mime_ext_local:setup({
  fallback_file1 = true,
  with_ext = {
    pcss = "text/css",
  },
})

boundary:setup()

linemode:setup()
