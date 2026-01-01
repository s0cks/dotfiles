local ON = "on";
local OFF = "off";

local borders = {
  active_color: "0xff8b7ec8",
  inactive_color: "0xff2827726",
  width: 4.0,
};

local options = {
  layout: 'bsp',
  focus_follows_mouse: OFF,
  mouse_follows_focus: ON,
  window_placement: 'second_child',
  window_shadow: 'float',
};

local win_pad = 4;
local win_gap = win_pad * 2;
local yabai = import 'lib/yabairc.libsonnet';

local spaces = [
  "work",
  "web",
  "chat",
  "music",
  "misc",
];

local WebSpaceRule(app, title = null) =
  yabai.AddSpaceRule(app, "^web", title);
local ChatSpaceRule(app, title = null) =
  yabai.AddSpaceRule(app, "^chat", title);
local WorkSpaceRule(app, title = null) =
  yabai.AddSpaceRule(app, "^work", title);
local MusicSpaceRule(app, title = null) =
  yabai.AddSpaceRule(app, "^music", title);

{
  ["yabairc"]:
    yabai.manifest([
      yabai.Comment("cleanup spaces", true),
      [
        "yabai -m query --spaces | jq -r '.[].index | select(. > 1)' | while read -r space; do yabai -m space --destroy \"$space\"; done",
      ],
      yabai.Comment("setup spaces", true),
      [
        yabai.Comment("create the %(space)s space" % { space: space }) +
        yabai.CreateSpace(space)
        for space in spaces
      ],
      yabai.Comment("misc", true),
      yabai.Padding(win_pad, win_pad, win_pad, win_pad, win_gap),
      // yabai.WindowOpacity(0.9, 1.0),
      yabai.Comment("rules", true),
      yabai.ManageRule(OFF, "^System Settings$"),
      // web space
      WebSpaceRule("Chrome$"),
      // chat space
      ChatSpaceRule("^Textual"),
      ChatSpaceRule("^wezterm-gui$", "weechat"),
      // work space
      WorkSpaceRule("^Obsidian"),
      WorkSpaceRule("^wezterm-gui$", "btm"),
      // music space
      MusicSpaceRule("^YouTube Music$"),
      // yabai.Borders(borders.inactive_color, borders.active_color, borders.width),
    ], true),
}
