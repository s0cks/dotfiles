local util = import 'lib/util.libsonnet';
{
  // TODO(@s0cks): support adding properties to plugins, see below
  PluginAttr(name, value):
    "%(name)s=\"%(value)s\"" % {
      name: name,
      value: value
    },
  Plugin(name, attrs = [], indent = 1):
    "%(indent)s%(name)s %(attrs)s" % {
      indent: util.IndentBy(indent),
      name: name,
      attrs: std.join(' ', attrs),
    },
  PluginWithLoc(name, loc, attrs = [], indent = 1):
    self.Plugin(name, [ self.PluginAttr('location', loc), ] + attrs, indent),
  PluginWithDefaultLoc(name, attrs = [], indent = 1):
    self.PluginWithLoc(name, 'zellij:' + name, attrs, indent),
  Plugins(plugins, indent = 0): |||
    %(indent)splugins {
      %(plugins)s
    %(indent_plus_one)sfilepicker location="zellij:strider" {
    %(indent_plus_two)scwd "/"
    %(indent_plus_one)s}
    %(indent_plus_one)swelcome-screen location="zellij:session-manager" {
    %(indent_plus_two)swelcome_screen true
    %(indent_plus_one)s}
    %(indent)s}
  ||| % {
    indent: util.IndentBy(indent),
    indent_plus_one: util.IndentBy( indent + 1),
    indent_plus_two: util.IndentBy( indent + 2),
    plugins: std.lines(plugins),
  },
}
