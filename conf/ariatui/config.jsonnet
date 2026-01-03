local ariatui = import 'lib/ariatui.libsonnet';
local ARIA2_TOKEN = std.extVar('ARIA2_SECRET');

{
  ["config.toml"]:
    ariatui.Config({
      general: ariatui.General(ARIA2_TOKEN),
      appearance: ariatui.Appearance(),
    }),
}
