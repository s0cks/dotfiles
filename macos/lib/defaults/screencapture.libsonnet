local defaults = import 'lib/defaults.libsonnet';

local APP = "com.apple.screencapture";
local app_defaults = {
  // Save screenshots to the desktop
  location: "${HOME}/Photos",
  // Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
  type: "png",
  // Disable shadow in screenshots
  ["disable-shadow"]: false,
};
defaults.WriteDefaultsMap(APP, app_defaults, false, true)
