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

local DEFAULT_ENV = [
  '/usr/local/bin',
  '/usr/bin',
  '/bin',
  '/usr/sbin',
  '/sbin',
  HOMEBREW_BIN,
];
local GetEnvPath(extras = []) =
  plist.SingleWrapString(std.join(':', DEFAULT_ENV + extras), 3);

{
  [GetPlistFilename("aria2")]: 
    plist.manifest([
      plist.Label(GetAppLabel('aria2')),
      plist.KeepAlive(),
      plist.RunAtLoad(),
      plist.WorkingDirectory(USER_HOME + '/Downloads'),
      plist.StandardOutPath(GetStdoutPath('aria2')),
      plist.StandardErrorPath(GetStderrPath('aria2')),
      plist.EnvironmentVariables({
        PATH: GetEnvPath(),
      }),
      plist.ProgramArguments(HOMEBREW_BIN + '/aria2c'),
    ]),
  [GetPlistFilename("wezterm")]: 
    plist.manifest([
      plist.Label(GetAppLabel('wezterm')),
      plist.KeepAlive(),
      plist.RunAtLoad(),
      plist.WorkingDirectory(USER_HOME),
      plist.StandardOutPath(GetStdoutPath('wezterm')),
      plist.StandardErrorPath(GetStderrPath('wezterm')),
      plist.EnvironmentVariables({
        PATH: GetEnvPath(),
      }),
      plist.ProgramArguments(HOMEBREW_BIN + '/wezterm', [
        plist.SingleWrapString("start", 3),
        plist.SingleWrapString("--always-new-process", 3),
      ]),
    ]),
  [GetPlistFilename("weechat")]: 
    plist.manifest([
      plist.Label(GetAppLabel('weechat')),
      plist.KeepAlive(),
      plist.RunAtLoad(),
      plist.StandardOutPath(GetStdoutPath('weechat')),
      plist.StandardErrorPath(GetStderrPath('weechat')),
      plist.EnvironmentVariables({
        PATH: GetEnvPath(),
      }),
      plist.ProgramArguments(HOMEBREW_BIN + '/wezterm', [
        plist.String('start', 3),
        plist.String('zellij', 3),
        plist.String("--layout", 3),
        plist.String('irc', 3),
      ]),
    ]),
}
