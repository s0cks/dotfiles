local COMPANY = std.extVar('COMPANY');
local USER_HOME = std.extVar('USER_HOME');
local ARIA2_HOME = std.extVar('ARIA2_HOME'); 
local HOMEBREW_BIN = std.extVar('HOMEBREW_BIN');
local XDG_CONFIG_HOME = std.extVar('XDG_CONFIG_HOME');

local ARIA2_CONFIG_DIR = XDG_CONFIG_HOME + '/aria2';
local ARIA2_CONFIG_FILE = ARIA2_CONFIG_DIR + '/aria2.conf';
local ARIA2_EXEC = HOMEBREW_BIN + '/aria2c';
local GenAria2Plist() = (importstr './templates/aria2.plist') % { 
  label: "%(company)s.aria2" % { company: COMPANY },
  aria2_exec: ARIA2_EXEC,
  aria2_home: ARIA2_HOME,
  aria2_conf: ARIA2_CONFIG_FILE,
};

local KITTY_EXEC = "/Applications/kitty.app/Contents/MacOS/kitty";
local GenKittyPlist() = (importstr './templates/kitty.plist') % {
  label: "%(company)s.kitty" % { company: COMPANY },
  exec: KITTY_EXEC,
  home_dir: USER_HOME,
};

local GetAppLabel(name) = '%(company)s.%(name)s' % {
  name: name,
  company: COMPANY,
};

local TMUX_EXEC = '/opt/homebrew/bin/tmux';
local GenTmuxPlist() = (importstr './templates/tmux.plist') % {
  label: "%(company)s.tmux" % { company: COMPANY },
  exec: TMUX_EXEC,
  session_name: "main",
};

local plist(app) = "%(company)s.%(app)s.plist" % { company: COMPANY, app: app };

{
  [plist("aria2")]: GenAria2Plist(),
  [plist("kitty")]: GenKittyPlist(),
  [plist("tmux")]: GenTmuxPlist(),
}
