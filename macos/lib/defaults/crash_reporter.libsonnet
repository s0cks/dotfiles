local defaults = import 'lib/defaults.libsonnet';

local APP = "com.apple.CrashReporter";
local app_defaults = {
  // Disable the crash reporter
  DialogType: "none",
};
defaults.WriteDefaultsMap(APP, app_defaults, false, true)
