
local defaults = import 'lib/defaults.libsonnet';

local APP = 'com.apple.finder';
local app_defaults = {
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
defaults.WriteDefaultsMap(APP, app_defaults, false, true)
