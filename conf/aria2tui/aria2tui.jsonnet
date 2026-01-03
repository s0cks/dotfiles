local aria2tui = import 'lib/aria2tui.libsonnet';
local ARIA2_TOKEN = std.extVar('ARIA2_SECRET');

{
  ["config.toml"]:
    aria2tui.Config({
      general: aria2tui.General(ARIA2_TOKEN),
      appearance: aria2tui.Appearance(),
    }),
}
