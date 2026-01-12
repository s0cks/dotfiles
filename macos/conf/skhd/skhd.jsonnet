local skhd = import 'lib/skhd.libsonnet';
local util = import 'lib/util.libsonnet';
local blacklist = import 'blacklist.json';

local HYPER = "hyper";
local CMD_SHIFT = [ "cmd", "shift" ];
local CTRL_SHIFT = [ "ctrl", "shift" ];

local BindYabaiFocusSpace(mod, key, space) =
  skhd.BindCall(mod, key, 'yabai_focus_space', space);
local BindYabaiWindowSwap(mod, key, dir) =
  skhd.BindCall(mod, key, 'yabai_window_swap', dir);
local BindYabaiWindowFocus(mod, key, dir) =
  skhd.BindCall(mod, key, "yabai_window_focus", dir);
local BindYabaiWindowResize(mod, key, dir, amt) =
  skhd.BindCall(mod, key, 'yabai_window_resize', [ dir, amt ]);
local BindYabaiWindowFocusStack(mod, key, dir) =
  skhd.BindCall(mod, key, 'yabai_window_focus_stack', dir);

local YabaiSpaces =
  skhd.Section("Yabai Spaces", [
    // cycle
    BindYabaiFocusSpace(HYPER, 'n', 'next'),
    BindYabaiFocusSpace(HYPER, 'p', 'prev'),
    // named
    BindYabaiFocusSpace(HYPER, 'c', 'chat'),
    BindYabaiFocusSpace(HYPER, 'b', 'web'),
    BindYabaiFocusSpace(HYPER, 'w', 'work'),
    BindYabaiFocusSpace(HYPER, 'm', 'music'),
    BindYabaiFocusSpace(HYPER, 'a', 'misc'),
  ], false, true);

local YabaiWindows =
  skhd.Section("Yabai Windows", [
    skhd.Section('focus', [
      BindYabaiWindowFocus(HYPER, "l", "east"),
      BindYabaiWindowFocus(HYPER, "h", "west"),
      BindYabaiWindowFocus(HYPER, "k", "north"),
      BindYabaiWindowFocus(HYPER, "j", "south"),
      BindYabaiWindowFocus(HYPER, "0x16", "first"),
      BindYabaiWindowFocus(HYPER, "0x15", "last"),
    ], false, true),
    skhd.Section("swap", [
      BindYabaiWindowSwap(CMD_SHIFT, "l", "east"),
      BindYabaiWindowSwap(CMD_SHIFT, "h", "west"),
      BindYabaiWindowSwap(CMD_SHIFT, "j", "south"),
      BindYabaiWindowSwap(CMD_SHIFT, "k", "north"),
    ], false, true),
    skhd.Section("resize", [
      BindYabaiWindowResize(CTRL_SHIFT, "l", "right", "10"),
      BindYabaiWindowResize(CTRL_SHIFT, "h", "right", "-10"),
      BindYabaiWindowResize(CTRL_SHIFT, "j", "bottom", "10"),
      BindYabaiWindowResize(CTRL_SHIFT, "k", "bottom", "-10"),
    ], false, true),
    skhd.Section("warp", [
      skhd.Bind(CMD_SHIFT, '0x21', 'yabai -m window --warp first'),
      skhd.Bind(CMD_SHIFT, '0x1e', 'yabai -m window --warp last'),
    ], false, true),
    skhd.Bind(CMD_SHIFT, 'w', 'yabai -m window --space "work"'),
    skhd.Bind(CMD_SHIFT, 'b', 'yabai -m window --space "web"'),
    skhd.Bind(CMD_SHIFT, 'a', 'yabai -m window --space "misc"'),
    skhd.Bind(CMD_SHIFT, 'm', 'yabai -m window --space "music"'),
    // stacking
    skhd.Bind(CMD_SHIFT, 'u', 'yabai -m window --toggle float && yabai -m window --toggle float'),
    BindYabaiWindowFocusStack(HYPER, '0x21', 'next'),
    BindYabaiWindowFocusStack(HYPER, '0x1e', 'prev'),
    skhd.Bind(HYPER, '0x27', 'yabai -m window --stack first || yabai -m window --focus first'),
  ], false, true);

local MiscBindings = 
  skhd.Section("Misc", [
    // skhd.BindCall(HYPER, "f1", 'yabai_toggle'),
    // skhd.BindCall(HYPER, "f11", 'restart_yabai'),
    // skhd.BindCall(HYPER, "f12", 'show_hs_console'),
    skhd.BindCall(HYPER, "d", 'open', "Google Drive.app"),
    skhd.Bind(HYPER, "0x2a", 'wezterm start --cwd ~ --always-new-process -- yazi ~'),
    skhd.Bind(HYPER, "e", [
      'yabai -m window --close',
      'yabai -m window --focus first',
    ]),
  ], false, true);

{
  ["skhdrc"]:
    skhd.manifest(
      blacklist,
      (import 'lib/skhd/commands.libsonnet') +
      YabaiWindows +
      YabaiSpaces +
      MiscBindings
    ),
}
