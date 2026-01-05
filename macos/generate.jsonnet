local defaults = import 'lib/defaults.libsonnet';

local FINDER = 'com.apple.finder';
local NS_GLOBAL_DOMAIN = "NSGlobalDomain";
local CRASH_REPORTER = "com.apple.CrashReporter";
local SCREEN_CAPTURE = "com.apple.screencapture";

local finder_defaults = {
  NewWindowTarget: "PfLo",
  NewWindowTargetPath: "file://${HOME}",
  AppleShowAllFiles: true,
  ShowPathbar: true,
  _FXSortFoldersFirst: true,
  FXDefaultSearchScope: 'SCcf',
  FXEnableExtensionChangeWarning: false,
  FXPreferredViewStyle: "nlsv",
  FXInfoPanesExpanded: true,
  WarnOnEmptyTrash: false,
};

local ns_global_domain_defaults = {
  // Save to disk (not to iCloud) by default
  NSDocumentSaveNewDocumentsToCloud: false,
  // Disable automatic capitalization as it’s annoying when typing code
  NSAutomaticCapitalizationEnabled: false,
  // Disable smart dashes as they’re annoying when typing code
  NSAutomaticDashSubstitutionEnabled: false,
  // Disable automatic period substitution as it’s annoying when typing code
  NSAutomaticPeriodSubstitutionEnabled: false,
  // Disable smart quotes as they’re annoying when typing code
  NSAutomaticQuoteSubstitutionEnabled: false,
  // Disable auto-correct
  NSAutomaticSpellingCorrectionEnabled: false,
  // Set language and text formats
  // Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
  // `Inches`, `en_GB` with `en_US`, and `true` with `false`.
  AppleLanguages: "en",
  AppleLocale: "en_US@currency=USD",
  AppleMeasurementUnits: "Centimeters",
  AppleMetricUnits: true,
};

local crash_reporter_defaults = {
  // Disable the crash reporter
  DialogType: "none",
};

local screencapture_defaults = {
  // Save screenshots to the desktop
  location: "${HOME}/Photos",
  // Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
  type: "png",
  // Disable shadow in screenshots
  ["disable-shadow"]: false,
};

local AppDefaults(app, defaults_map = []) =
  [
    defaults.WriteDefaults(app, name, defaults_map[name])
    for name in std.objectFields(defaults_map)
  ];

{
  "defaults.sh":
    std.lines(
      defaults.Header(false, true) +
      [
        "# references:",
        "# - https://github.com/driesvints/dotfiles/blob/main/.macos",
        "osascript -e 'tell application \"System Preferences\" to quit'",
        "sudo -v",
        "while true; do",
        "  sudo -n true",
        "  sleep 60",
        "  kill -0 \"$$\" || exit",
        "done 2>/dev/null &",
        "# disable boot sounds",
        "sudo nvram SystemAudioVolume=\" \"",
      ]
    )+
    defaults.DefaultsFile(
      AppDefaults(FINDER, finder_defaults) +
      AppDefaults(NS_GLOBAL_DOMAIN, ns_global_domain_defaults) +
      AppDefaults(SCREEN_CAPTURE, screencapture_defaults) + 
      AppDefaults(CRASH_REPORTER, crash_reporter_defaults)
    )
}
