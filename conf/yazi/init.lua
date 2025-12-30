require("starship"):setup({})

require("full-border"):setup({
  type = ui.Border.THICK,
})

th.git = th.git or {}
th.git.modified = ui.Style():fg("#8B7EC8")
th.git.modified_sign = "M"
th.git.deleted = ui.Style():fg("#D14D41"):bold()
th.git.deleted_signed = "D"
require("git"):setup()

require("mactag"):setup({
  keys = {
    r = "Red",
    o = "Orange",
    y = "Yellow",
    g = "Green",
    b = "Blue",
    p = "Purple",
  },
  colors = {
    Red = "#D14D41",
    Orange = "#DA702C",
    Yellow = "#D0A215",
    Green = "#879A39",
    Blue = "#4385BE",
    Purple = "#8B7EC8",
  },
})

require("fg"):setup({
  default_action = "menu",
})

local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")
if ya.target_family() == "windows" then
  table.insert(bookmarks, {
    tag = "Scoop Local",
    path = (os.getenv("SCOOP") or home_path .. "\\scoop") .. "\\",
    key = "p",
  })
  table.insert(bookmarks, {
    tag = "Scoop Global",
    path = (os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop") .. "\\",
    key = "P",
  })
end
table.insert(bookmarks, {
  tag = "Desktop",
  path = home_path .. path_sep .. "Desktop" .. path_sep,
  key = "d",
})

require("yamb"):setup({
  -- Optional, the path ending with path seperator represents folder.
  bookmarks = bookmarks,
  -- Optional, recieve notification everytime you jump.
  jump_notify = true,
  -- Optional, the cli of fzf.
  cli = "fzf",
  -- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
  keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  -- Optional, the path of bookmarks
  path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark")
    or (os.getenv("HOME") .. "/.config/yazi/bookmark"),
})
