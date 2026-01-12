{
  // Triggered when a new application is launched.
  // Eligible for app filter.
  // Passes one argument: $YABAI_PROCESS_ID
  APPLICATION_LAUNCHED: "application_launched",

  // Triggered when an application is terminated.
  // Eligible for app and active filter.
  // Passes one argument: $YABAI_PROCESS_ID
  APPLICATION_TERMINATED: "application_terminated",

  // Triggered when the front-most application changes.
  // Passes two arguments: $YABAI_PROCESS_ID, $YABAI_RECENT_PROCESS_ID
  APPLICATION_FRONT_SWITCHED: "application_front_switched",

  // Triggered when an application is activated.
  // Eligible for app filter.
  // Passes one argument: $YABAI_PROCESS_ID
  APPLICATION_ACTIVATED: "application_activated",

  // Triggered when an application is deactivated.
  // Eligible for app filter.
  // Passes one argument: $YABAI_PROCESS_ID
  APPLICATION_DEACTIVATED: "application_deactivated",

  // Triggered when an application is unhidden.
  // Eligible for app filter.
  // Passes one argument: $YABAI_PROCESS_ID
  APPLICATION_VISIBLE: "application_visible",

  // Triggered when an application is hidden.
  // Eligible for app and active filter.
  // Passes one argument: $YABAI_PROCESS_ID
  APPLICATION_HIDDEN: "application_hidden",

  // Triggered when a window is created.
  // Also applies to windows that are implicitly created at application launch.
  // Eligible for app and title filter.
  // Passes one argument: $YABAI_WINDOW_ID
  WINDOW_CREATED: "window_created",

  // Triggered when a window is destroyed.
  // Also applies to windows that are implicitly destroyed at application exit.
  // Eligible for app and active filter.
  // Passes one argument: $YABAI_WINDOW_ID
  WINDOW_DESTROYED: "window_destroyed",

  // Triggered when a window becomes the key-window.
  // Eligible for app and title filter.
  // Passes one argument: $YABAI_WINDOW_ID
  WINDOW_FOCUSED: "window_focused",

  // Triggered when a window changes position.
  // Eligible for app, title and active filter.
  // Passes one argument: $YABAI_WINDOW_ID
  WINDOW_MOVED: "window_moved",

  // Triggered when a window changes dimensions.
  // Eligible for app, title and active filter.
  // Passes one argument: $YABAI_WINDOW_ID
  WINDOW_RESIZED: "window_resized",

  // Triggered when a window has been minimized.
  // Eligible for app, title and active filter.
  // Passes one argument: $YABAI_WINDOW_ID
  WINDOW_MINIMIZED: "window_minimized",

  // Triggered when a window has been deminimized.
  // Eligible for app and title filter.
  // Passes one argument: $YABAI_WINDOW_ID
  WINDOW_DEMINIMIZED: "window_deminimized",

  // Triggered when a window changes its title.
  // Eligible for app, title and active filter.
  // Passes one argument: $YABAI_WINDOW_ID
  WINDOW_TITLE_CHANGED: "window_title_changed",

  // Triggered when a space is created.
  // Passes two arguments: $YABAI_SPACE_ID, $YABAI_SPACE_INDEX
  SPACE_CREATED: "space_created",

  // Triggered when a space is destroyed.
  // Passes one argument: $YABAI_SPACE_ID
  SPACE_DESTROYED: "space_destroyed",

  // Triggered when the active space has changed.
  // Passes four arguments: $YABAI_SPACE_ID, $YABAI_SPACE_INDEX, $YABAI_RECENT_SPACE_ID, $YABAI_RECENT_SPACE_INDEX
  SPACE_CHANGED: "space_changed",

  // Triggered when a new display has been added.
  // Passes two arguments: $YABAI_DISPLAY_ID, $YABAI_DISPLAY_INDEX
  DISPLAY_ADDED: "display_added",

  // Triggered when a display has been removed.
  // Passes one argument: $YABAI_DISPLAY_ID
  DISPLAY_REMOVED: "display_removed",

  // Triggered when a change has been made to display arrangement.
  // Passes two arguments: $YABAI_DISPLAY_ID, $YABAI_DISPLAY_INDEX
  DISPLAY_MOVED: "display_moved",

  // Triggered when a display has changed resolution.
  // Passes two arguments: $YABAI_DISPLAY_ID, $YABAI_DISPLAY_INDEX
  DISPLAY_RESIZED: "display_resized",

  // Triggered when the active display has changed.
  // Passes four arguments: $YABAI_DISPLAY_ID, $YABAI_DISPLAY_INDEX, $YABAI_RECENT_DISPLAY_ID, $YABAI_RECENT_DISPLAY_INDEX
  DISPLAY_CHANGED: "display_changed",

  // Triggered when mission-control activates.
  // Passes one argument: $YABAI_MISSION_CONTROL_MODE
  MISSION_CONTROL_ENTER: "mission_control_enter",

  // Triggered when mission-control deactivates.
  // Passes one argument: $YABAI_MISSION_CONTROL_MODE
  MISSION_CONTROL_EXIT: "mission_control_exit",

  // Triggered when the macOS Dock preferences changes.
  DOCK_DID_CHANGE_PREF: "dock_did_change_pref",

  // Triggered when Dock.app restarts.
  DOCK_DID_RESTART: "dock_did_restart",

  // Triggered when the macOS menubar autohide setting changes.
  MENU_BAR_HIDDEN_CHANGED: "menu_bar_hidden_changed",

  // Triggered when macOS wakes from sleep.
  SYSTEM_WOKE: "system_woke",
}
