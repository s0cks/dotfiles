local yabai   = import 'lib/yabai.libsonnet';
local apps    = import 'lib/yabai/apps.libsonnet';

local WebSpaceRule(app, title = null) =
  yabai.AddSpaceRule(app, "^web", title);
local WebSpaceRules = 
  [
    WebSpaceRule("Chrome$"),
  ];

local ChatSpaceRule(app, title = null) =
  yabai.AddSpaceRule(app, "^chat", title);
local ChatSpaceRules = 
  [
    ChatSpaceRule("^Textual"),
    ChatSpaceRule(apps.WEZTERM, "weechat"),
  ];

local WorkSpaceRule(app, title = null) =
  yabai.AddSpaceRule(app, "^work", title);
local WorkSpaceRules = 
  [
    WorkSpaceRule("^Obsidian"),
    WorkSpaceRule(apps.WEZTERM, "btm"),
  ];

local MusicSpaceRule(app, title = null) =
  yabai.AddSpaceRule(app, "^music", title);
local MusicSpaceRules = 
  [
    MusicSpaceRule(apps.YOUTUBE_MUSIC),
  ];

local MiscSpaceRule(app, title = null) =
  yabai.AddSpaceRule(app, "^misc", title);
local MiscSpaceRules = 
  [
    MiscSpaceRule(apps.GOOGLE_DRIVE),
  ];

WebSpaceRules +
ChatSpaceRules +
WorkSpaceRules +
MusicSpaceRules +
MiscSpaceRules
