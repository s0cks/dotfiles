local skhd = import 'lib/skhd.libsonnet';

local commands = {
  ["open"]: "open '{{1}}'",
  ["yabai_layout"]: "yabai -m config layout {{1}}",
  ["yabai_toggle"]: "[[ $(yabai -m query --spaces --space | jq -r '.type') == \"float\" ]] && yabai -m config layout bsp || yabai -m config layout float",
  ["yabai_focus_on_app"]: "yabai -m window --focus $(yabai -m query --windows | jq -r '.[] | select(.app == \"{{1}}\").id') ",
  // space
  ["yabai_focus_space"]: "yabai -m space --focus {{1}}",
  // window
  ["yabai_window_warp"]: "yabai -m window --warp {{1}}",
  ["yabai_window_move_to_space"]: "yabai -m window --space {{1}}",
  ["yabai_window_toggle"]: "yabai -m window --toggle {{1}}",
  ["yabai_window_focus"]: "yabai -m window --focus {{1}}",
  ["yabai_window_swap"]: "yabai -m window --swap {{1}}",
  ["yabai_window_resize"]: "yabai -m window --resize {{1}}:{{2}}",
  ["yabai_window_focus_stack"]: "yabai -m window --focus stack.{{1}}",
  ["test"]: [
    "yabai -m window $(yabai -m query --windows | jq -r '.[] | select(.app == \"{{1}}\").id') --space 1",
    "([[ \"$(yabai -m query --windows | jq -r '.[] | select(.app == \"{{1}}\")[\"is-native-fullscreen\"]')\" == \"true\" ]] && yabai -m window \"$(yabai -m query --windows | jq -r '.[] | select(.app == \"{{1}}\").id')\" --toggle native-fullscreen || return 0)",
    "yabai -m window $(yabai -m query --windows | jq -r '.[] | select(.app == \"{{1}}\").id') --warp first",
  ]
};

skhd.Section("Commands",
  [
    skhd.DefineCommand(name, commands[name])
    for name in std.objectFields(commands)
  ],
  false, true)
