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

{
  ["yabairc"]:
    yabai.manifest([
      yabai.Comment("cleanup spaces", true),
      [
        yabai.DestroySpace(idx + 1)
        for idx in std.range(0, std.length(spaces) - 1)
      ],
      yabai.Comment("setup spaces", true),
      [ "local index" ],
      [
        yabai.Comment("create the %(space)s space" % { space: space }) +
        yabai.CreateSpace(space)
        for space in spaces
      ],
      [ "unset index" ],
      yabai.Comment("misc", true),
      yabai.Padding(win_pad, win_pad, win_pad, win_pad, win_gap),
      // yabai.WindowOpacity(0.9, 1.0),
      yabai.Comment("rules", true),
      yabai.ManageRule(OFF, "^System Settings$"),
      yabai.AddSpaceRule("Chrome$", "^2"),
      yabai.AddSpaceRule("Textual", "^3"),
      // yabai.Borders(borders.inactive_color, borders.active_color, borders.width),
    ], true),
}
