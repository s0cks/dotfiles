local yabai   = import 'lib/yabai.libsonnet';
local apps    = import 'lib/yabai/apps.libsonnet';
local XDG_CONFIG_HOME = std.extVar("XDG_CONFIG_HOME");

local YabaiScript(name) = XDG_CONFIG_HOME + "/yabai/" + name;

local borders = {
  active_color: "0xff8b7ec8",
  inactive_color: "0xff2827726",
  width: 4.0,
};


local Signals =
  [
    yabai.Comment("Signals", true),
    yabai.OnAppLaunched(YabaiScript("focus-yazi"), apps.WEZTERM, "^Yazi:"),
  ];

{
  ["yabairc"]:
    yabai.manifest(
      (import 'lib/yabai/config.libsonnet') +
      (import 'lib/yabai/spaces.libsonnet') +
      (import 'lib/yabai/management_rules.libsonnet') +
      (import 'lib/yabai/space_rules.libsonnet') +
      Signals + 
      [
        // yabai.Borders(borders.inactive_color, borders.active_color, borders.width),
      ],
      true
    ),
}
