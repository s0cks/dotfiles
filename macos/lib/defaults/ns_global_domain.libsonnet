
local defaults = import 'lib/defaults.libsonnet';

local APP = "NSGlobalDomain";
local app_defaults = {
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
defaults.WriteDefaultsMap(APP, app_defaults, false, true)
