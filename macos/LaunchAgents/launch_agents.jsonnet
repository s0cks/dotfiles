local COMPANY = std.extVar('COMPANY');
local USER_HOME = std.extVar('USER_HOME');
local HOMEBREW_REPOSITORY = std.extVar('HOMEBREW_REPOSITORY');
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
      HOMEBREW_REPOSITORY + '/bin',
    ] +
    extras
  ), indent);

{
  [GetPlistFilename("aria2")]: 
    plist.manifest([
      plist.Label(GetAppLabel('aria2c')),
      plist.KeepAlive(),
      plist.RunAtLoad(),
      plist.WorkingDirectory(USER_HOME + '/Downloads'),
      plist.StandardOutPath(GetStdoutPath('aria2c')),
      plist.StandardErrPath(GetStderrPath('aria2c')),
      plist.EnvironmentVariables({
        PATH: GetEnvPath(),
      }),
      plist.ProgramArguments([
        plist.String('aria2c', 3),
        plist.String('--conf-path', 3),
        plist.String(XDG_CONFIG_HOME + '/aria2/aria2.conf', 3),
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
        plist.String('wezterm', 3),
      ]),
    ]),
}
