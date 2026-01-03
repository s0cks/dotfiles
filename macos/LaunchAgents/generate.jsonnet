local COMPANY = std.extVar('COMPANY');
local USER_HOME = std.extVar('HOME');
local HOMEBREW_REPOSITORY = std.extVar('HOMEBREW_REPOSITORY');
local HOMEBREW_BIN = HOMEBREW_REPOSITORY + '/bin';
local XDG_CONFIG_HOME = std.extVar('XDG_CONFIG_HOME');
local plist = import 'lib/plist.libsonnet';

local GetAppLabel(name) = 
  '%(company)s.%(name)s' % {
    name: name,
    company: COMPANY,
  };

local GetPlistFilename(app) = 
  "%(label)s.plist" % {
    label: GetAppLabel(app),
  };

local GetStdoutPath(app) =
  "/tmp/%(app)s.out.log" % {
    app: app
  };

local GetStderrPath(app) =
  "/tmp/%(app)s.err.log" % {
    app: app
  };

local GetEnvPath(extras = [], indent = 3) =
  plist.String(std.join(':',
    [
      '/usr/local/bin',
      '/usr/bin',
      '/bin',
      '/usr/sbin',
      '/sbin',
      HOMEBREW_BIN,
    ] +
    extras
  ), indent);

{
  [GetPlistFilename("aria2")]: 
    plist.manifest([
      plist.Label(GetAppLabel('aria2')),
      plist.KeepAlive(),
      plist.RunAtLoad(),
      plist.WorkingDirectory(USER_HOME + '/Downloads'),
      plist.StandardOutPath(GetStdoutPath('aria2')),
      plist.StandardErrPath(GetStderrPath('aria2')),
      plist.EnvironmentVariables({
        PATH: GetEnvPath(),
      }),
      plist.ProgramArguments([
        plist.String(HOMEBREW_BIN + '/aria2c', 3),
      ]),
    ]),
  [GetPlistFilename("wezterm")]: 
    plist.manifest([
      plist.Label(GetAppLabel('wezterm')),
      plist.KeepAlive(),
      plist.RunAtLoad(),
      plist.WorkingDirectory(USER_HOME),
      plist.StandardOutPath(GetStdoutPath('wezterm')),
      plist.StandardErrPath(GetStderrPath('wezterm')),
      plist.EnvironmentVariables({
        PATH: GetEnvPath(),
      }),
      plist.ProgramArguments([
        plist.String(HOMEBREW_BIN + '/wezterm', 3),
      ]),
    ]),
  [GetPlistFilename("weechat")]: 
    plist.manifest([
      plist.Label(GetAppLabel('weechat')),
      plist.KeepAlive(),
      plist.RunAtLoad(),
      plist.StandardOutPath(GetStdoutPath('weechat')),
      plist.StandardErrPath(GetStderrPath('weechat')),
      plist.EnvironmentVariables({
        PATH: GetEnvPath(),
      }),
      plist.ProgramArguments([
        plist.String(HOMEBREW_BIN + '/wezterm', 3),
        plist.String('start', 3),
        plist.String('zellij', 3),
        plist.String("--layout", 3),
        plist.String('irc', 3),
      ]),
    ]),
}
