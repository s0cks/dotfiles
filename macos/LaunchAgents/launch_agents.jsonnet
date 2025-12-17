local COMPANY = std.extVar('COMPANY');
local USER_HOME = std.extVar('USER_HOME');
local HOMEBREW_REPOSITORY = std.extVar('HOMEBREW_REPOSITORY');
local XDG_CONFIG_HOME = std.extVar('XDG_CONFIG_HOME');

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

local JoinProgramArgs(args) = 
  std.join(" ", [
    "<string>%(arg)s</string>\n" % { arg: arg }
    for arg in args
  ]);

local GenProgramArguments(args) = |||
  <key>ProgramArguments</key>
  <array>
  %(args)s
  </array>
||| % {
  args: JoinProgramArgs(args)
};


local GetKeepAlive(config) = 
  if "keep_alive" in config then
    config.keep_alive
  else
    true;

local GetRunAtLoad(config) =
  if "run_at_load" in config then
    config.run_at_load
  else
    true;

local GenCwd(config) = 
  if "cwd" in config then
    |||
      <key>WorkingDirectory</key>
      <string>%(cwd)s</string>
    ||| % { cwd: config.cwd % { xdg_config_dir: XDG_CONFIG_HOME } }
  else
    "";


local GenStdout(app, config) =
  if "stdout" in config then
    |||
      <key>StandardOutPath</key>
      <string>%(path)s</string>
    ||| % { path: GetStdoutPath(app) }
  else
    "";

local GenStderr(app, config) =
  if "stderr" in config then
    |||
      <key>StandardErrPath</key>
      <string>%(path)s</string>
    ||| % { path: GetStderrPath(app) }
  else
    "";

local GetArgs(config) =
  if "args" in config then
    [
      value % { xdg_config_dir: XDG_CONFIG_HOME, homebrew_dir: HOMEBREW_REPOSITORY }
      for value in config.args
    ]
  else
    [];

local GenPlist(app, config, args) = (importstr './_default.plist') % {
  app: app,
  label: GetAppLabel(app),
  keep_alive: GetKeepAlive(config),
  run_at_load: GetRunAtLoad(config),
  cwd: GenCwd(config),
  stdout: GenStdout(app, config),
  stderr: GenStderr(app, config),
  args: GenProgramArguments(args),
};

local aria2 = (import './aria2.json');
local GenAria2Plist() = GenPlist("aria2", aria2, GetArgs(aria2));

local kitty = (import './kitty.json');
local GenKittyPlist() = GenPlist("kitty", kitty, GetArgs(kitty));

local zellij = (import './zellij.json');
local GenZellijPlist() = GenPlist('zellij', zellij, GetArgs(zellij));

{
  [GetPlistFilename("aria2")]: GenAria2Plist(), 
  [GetPlistFilename("kitty")]: GenKittyPlist(),
  [GetPlistFilename("zellij")]: GenZellijPlist(),
}
