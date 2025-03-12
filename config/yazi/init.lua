local git = require("git")
local mime_ext = require("mime-ext")
local session = require("session")

local linemode = require("linemode")

session:setup({
  sync_yanked = true,
})

THEME.git = THEME.git or {}
THEME.git.added_sign = "A"
THEME.git.deleted_sign = "D"
THEME.git.ignored_sign = "I"
THEME.git.modified_sign = "M"
THEME.git.updated_sign = "U"
THEME.git.untracked_sign = "?"

git:setup({
  order = -math.huge,
})

mime_ext:setup({
  fallback_file1 = true,
})

linemode:setup()
