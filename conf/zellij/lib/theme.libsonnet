local util = import 'lib/util.libsonnet';
local kdl = import 'lib/kdl.libsonnet';

local SectionField(name, value, indent = 0) =
  "%(indent)s%(name)s %(value)s" % {
    indent: util.FillString('  ', indent),
    name: name,
    value: value,
  };
local blk = "0 0 0";

{
  Theme(name, props, indent = 0):
    kdl.Section(name, props, indent),
  Component(name, fg, bg, emp0 = blk, emp1 = blk, emp2 = blk, emp3 = blk, indent = 0):
    kdl.Section(name, [
      kdl.Property("base", fg, indent + 1, false),
      kdl.Property('background', bg, indent + 1, false),
      kdl.Property('emphasis_0', emp0, indent + 1, false),
      kdl.Property('emphasis_1', emp1, indent + 1, false),
      kdl.Property('emphasis_2', emp2, indent + 1, false),
      kdl.Property('emphasis_3', emp3, indent + 1, false),
    ], indent),
  ComponentWithEmphasis(name, fg, bg, emp = [], indent = 0):
    self.Component(name, fg, bg, emp[0], emp[1], emp[2], emp[3], indent),
  ComponentWithNoEmphasis(name, fg, bg, indent = 0):
    self.ComponentWithEmphasis(name, fg, bg, std.repeat([ blk, ], 4), indent),
  MultiplayerUserColors(colors, indent = 0):
    kdl.Section("multiplayer_user_colors",
     std.mapWithIndex(
     function(idx, elem)
      kdl.Property("player_" + idx, elem, indent + 1, false),
      colors), indent)
}
