local rg = import 'lib/rg.libsonnet';
local patterns = import 'custom_types.json';

local Misc() = 
  [
    rg.Comment("Misc", true),
    rg.MaxColumns(80),
    rg.MaxColumnsPreview(),
    rg.SmartCase(),
    rg.Follow(),
    rg.Hidden(),
    rg.GitGlob(),
  ];

local Types() =
  [
    rg.Comment("File Types", true),
    std.mapWithIndex(
      function(index, name)
        rg.TypeAdd(name, patterns[name], index > 0),
    std.objectFields(patterns)),
  ];

{
  "config":
    rg.Config(
      Misc() +
      Types(),
      false, true),
}
