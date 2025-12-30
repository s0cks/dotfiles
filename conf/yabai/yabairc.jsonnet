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

{
  ["yabairc"]:
    yabai.manifest([
      yabai.Comment('misc'),
      yabai.Padding(win_pad, win_pad, win_pad, win_pad, win_gap),
      yabai.WindowOpacity(0.9, 1.0),
      yabai.Comment('rules'),
      yabai.ManageRule(OFF, "^System Preferences$"),
      yabai.Borders(borders.inactive_color, borders.active_color, borders.width),
    ]),
}
