local util = import 'lib/util.libsonnet';
local events = import 'lib/yabai/events.libsonnet';

{
  ON: "on",
  OFF: "off",
  local NEWLINE = [ "" ],
  Comment(text, newline_before = false, newline_after = false):
    (if newline_before then NEWLINE else []) +
    [
      "# %(text)s" % { text: line }
      for line in (if std.isArray(text) then text else [ text ])
    ] +
    (if newline_after then NEWLINE else []),
  local Filters(filters) =
    std.join(" ", [
      "--" + name + " " + filters[name]
      for name in std.objectFields(filters)
    ]),
  Config(name, value, filters = {}):
    "yabai -m config" +
    (if filters != null then " " + Filters(filters) + " " else " ") +
    name + " " + value,
  local LabelLastSpace(label) =
    "yabai -m space $(yabai -m query --spaces | jq -r '[ .[] | select(.\"is-native-fullscreen\" == false) ][-1].index') --label " + label,
  CreateSpace(label = null):
    [
      "[[ -z $(yabai -m query --spaces --space \"%(space)s\") ]] && yabai -m space --create",
    ] +
    (if label != null then [ LabelLastSpace(label) ] else []),
  CreateSpaceIfNotExists(idx, label, layout = 'bsp'):
    [
      "[[ -z \"$(yabai -m query --spaces --space %(space)s)\" ]] && yabai -m space --create" % { space: idx },
      "yabai -m space %(space)s --label \"%(label)s\"" % { space: idx, label: label },
      $.Layout(layout, idx),
    ],
  DestroySpace(idx):
    [
      "yabai -m space --destroy %(idx)d" % { idx: idx },
    ],
  Layout(name, space = null):
    $.Config("layout", name, (if space != null then { space: space } else {})),
  Padding(top, bottom, left, right, gap):
    [
      self.Config('top_padding', top),
      self.Config('bottom_padding', bottom),
      self.Config('left_padding', left),
      self.Config('right_padding', right),
      self.Config('window_gap', gap),
    ],
  WindowPlacement(dir):
    $.Config("window_placement", dir),
  WindowPlacementFirstChild: $.WindowPlacement("first_child"),
  WindowPlacementSecondChild: $.WindowPlacement("second_child"),
  WindowOpacityConfig(state):
    self.Config('window_opacity', state),
  DisableWindowOpacity: self.WindowOpacityConfig('off'),
  WindowOpacity(normal, active):
    [
      self.Comment('Window Opacity'),
      self.WindowOpacityConfig('on'),
      self.Config('normal_window_opacity', normal),
      self.Config('active_window_opacity', active),
    ],
  AddRule(app, args):
    [
      "yabai -m rule --add app=\"%(app)s\" %(rule)s" % {
        app: app,
        rule: (if std.isArray(args) then std.join(' ', args) else args),
      },
    ],
  RuleArg(key, value, quote = false):
    "%(key)s=%(value)s" % {
      key: key,
      value: (if quote then '"' + value + '"' else value)
    },
  AddSpaceRule(app, space, title = null):
    $.AddRule(app,
      [ $.RuleArg("space", space, true) ] +
      (if title != null then [ $.RuleArg("title", title, true) ] else [])
    ),
  ManageRule(state, app, title = null):
    $.AddRule(app,
      [ $.RuleArg("app", app, true) ] +
      (if title != null then [ $.RuleArg("title", title, true) ] else []) +
      [ $.RuleArg("manage", state) ]
    ),
  ManageOffRule(app, title = null):
    $.ManageRule("off", app, title),
  Borders(inactive_color, active_color, width):
    [
      self.Comment('borders'),
      "borders active_color=%(active_color)s inactive_color=%(inactive_color)s width=%(width)s &" % {
        inactive_color: inactive_color,
        active_color: active_color,
        width: width,
      }
    ],
  local LOAD_SCRIPTING = "sudo yabai --load-sa",
  LoadScripting():
    $.Comment([
      "Enable Scripting",
    ], true) +
    [
      $.OnDockDidRestart(LOAD_SCRIPTING),
      LOAD_SCRIPTING,
    ],
  Signal(event, action, filters = []):
    [
      'yabai -m signal --add event=%(event)s %(filters)s action="%(action)s"' % {
        event: event,
        action: action,
        filters:
            if filters == null then
              ""
            else if std.isObject(filters) then
              std.join(" ", std.filter(function(x) x != null, [
                filter + "=" + util.Quote(filters[filter])
                for filter in std.objectFields(filters)
              ]))
            else if std.isArray(filters) then
              std.join(" ", std.filter(function(x) x != null, filters))
            else
              filters,
      },
    ],

	OnAppLaunched(action, app = null, title = null):
    $.Signal(events.APPLICATION_LAUNCHED, action, { app: app, title: title }),
	OnAppTerminated(action, app = null, title = null):
    $.Signal(events.APPLICATION_TERMINATED, action, { app: app, title: title }),
	OnAppFrontSwitched(action, app = null, title = null):
    $.Signal(events.APPLICATION_FRONT_SWITCHED, action, { app: app, title: title }),
	OnAppActivated(action, app = null, title = null):
    $.Signal(events.APPLICATION_ACTIVATED, action, { app: app, title: title }),
	OnAppDeactivated(action, app = null, title = null):
    $.Signal(events.APPLICATION_DEACTIVATED, action, { app: app, title: title }),
	OnAppVisible(action, app = null, title = null):
    $.Signal(events.APPLICATION_VISIBLE, action, { app: app, title: title }),
	OnAppHidden(action, app = null, title = null):
    $.Signal(events.APPLICATION_HIDDEN, action, { app: app, title: title }),

	OnWindowCreated(action):
		$.Signal(events.WINDOW_CREATED, action),
	OnWindowDestroyed(action):
		$.Signal(events.WINDOW_DESTROYED, action),
	OnWindowFocused(action):
		$.Signal(events.WINDOW_FOCUSED, action),
	OnWindowMoved(action):
		$.Signal(events.WINDOW_MOVED, action),
	OnWindowResized(action):
		$.Signal(events.WINDOW_RESIZED, action),
	OnWindowMinimized(action):
		$.Signal(events.WINDOW_MINIMIZED, action),
	OnWindowDeminimized(action):
		$.Signal(events.WINDOW_DEMINIMIZED, action),
	OnWindowTitleChanged(action):
		$.Signal(events.WINDOW_TITLE_CHANGED, action),
	OnSpaceCreated(action):
		$.Signal(events.SPACE_CREATED, action),
	OnSpaceDestroyed(action):
		$.Signal(events.SPACE_DESTROYED, action),
	OnSpaceChanged(action):
		$.Signal(events.SPACE_CHANGED, action),
	OnDisplayAdded(action):
		$.Signal(events.DISPLAY_ADDED, action),
	OnDisplayRemoved(action):
		$.Signal(events.DISPLAY_REMOVED, action),
	OnDisplayMoved(action):
		$.Signal(events.DISPLAY_MOVED, action),
	OnDisplayResized(action):
		$.Signal(events.DISPLAY_RESIZED, action),
	OnDisplayChanged(action):
		$.Signal(events.DISPLAY_CHANGED, action),
	OnMissionControlEnter(action):
	  $.Signal(events.MISSION_CONTROL_ENTER, action),
	OnMissionControlExit(action):
		$.Signal(events.MISSION_CONTROL_EXIT, action),
	OnDockDidChangePref(action):
		$.Signal(events.DOCK_DID_CHANGE_PREF, action),
	OnDockDidRestart(action):
		$.Signal(events.DOCK_DID_RESTART, action),
	OnMenuBarHiddenChanged(action):
		$.Signal(events.MENU_BAR_HIDDEN_CHANGED, action),
	OnSystemWoke(action):
		$.Signal(events.SYSTEM_WOKE, action),
  manifest(config, newline_after):
    std.lines(std.flattenDeepArray(
      $.Comment([
        "** Do not edit **",
        "This file is generated by Jsonnet",
        "vim: set ft=zsh:"
      ]) +
      $.LoadScripting() +
      config +
      (if newline_after then NEWLINE else []),
    )),
}
