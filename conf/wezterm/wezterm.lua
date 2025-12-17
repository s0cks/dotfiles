local wt = require("wezterm")
local config = wt.config_builder()
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 14

config.color_scheme = "flexoki-dark"
config.default_prog = { "/opt/homebrew/bin/zellij" }
config.font = wt.font({
  family = "Monaspace Argon Var",
  style = "Normal",
  harfbuzz_features = {
    "+liga",
    "+ital",
    "+ss01",
    "+ss02",
    "+ss03",
    "+ss04",
    "+ss05",
    "+ss06",
    "+ss07",
    "+ss08",
    "+ss09",
    "+ss10",
  },
})
config.window_background_opacity = 0.7
config.default_prog = { "/opt/homebrew/bin/zellij", "attach", "main" }
return config
