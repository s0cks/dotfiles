local yabai   = import 'lib/yabai.libsonnet';
local apps    = import 'lib/yabai/apps.libsonnet';

[
  yabai.Comment("Management Rules", true),
  yabai.ManageOffRule(apps.SYSTEM_SETTINGS),
  yabai.ManageOffRule(apps.WEZTERM, "^Yazi:"),
]
