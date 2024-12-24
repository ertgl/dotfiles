local session = require("session")

local linemode = require("linemode")

session:setup({
  sync_yanked = true,
})

linemode:setup()
