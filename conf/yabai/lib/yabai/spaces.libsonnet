local yabai = import 'lib/yabai.libsonnet';

local spaces = [
  "work",
  "web",
  "chat",
  "music",
  "misc",
];

[ yabai.Comment("Spaces", true) ] +
[
  yabai.Comment("Create the %(space)s space" % { space: spaces[idx] }, idx > 0) +
  yabai.CreateSpaceIfNotExists(idx + 1, spaces[idx])
  for idx in std.range(0, std.length(spaces) - 1)
]
