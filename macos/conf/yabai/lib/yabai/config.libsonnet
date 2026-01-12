local yabai = import 'lib/yabai.libsonnet';

local options = {
  layout: 'bsp',
  focus_follows_mouse: yabai.OFF,
  mouse_follows_focus: yabai.ON,
  window_placement: 'second_child',
  window_shadow: 'float',
};

local win_pad = 4;
local win_gap = win_pad * 2;
[
  yabai.Comment("Config", true),
  yabai.Padding(win_pad, win_pad, win_pad, win_pad, win_gap),
]
