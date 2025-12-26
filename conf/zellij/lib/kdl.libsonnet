local util = import 'lib/util.libsonnet';
{
  BlockComment(value):
    std.lines(std.flattenArrays([
      [ "//" + std.repeat("*", 50) ],
      std.map(function(x) "//* " + x, if std.isArray(value) then value else [ value ]),
      [ "//" + std.repeat("*", 50) ],
    ])),
  Property(name, value, indent = 0, escape = true):
    "%(indent)s%(name)s %(value)s" % {
      indent: util.IndentBy(indent),
      name: name,
      value: if std.isString(value) && escape then ("\"%(value)s\"" % { value: value }) else value,
    },
  Section(name, props = [], indent = 0):
    if std.isArray(props) then
      if std.length(props) == 0 then
        "%(indent)s%(name)s { }\n" % {
          indent: util.IndentBy(indent),
          name: name,
        }
      else
        |||
          %(indent)s%(name)s {
          %(props)s
          %(indent)s}
        ||| % {
          name: name,
          props: std.lines(props),
          indent: util.IndentBy(indent),
          indent_plus_one: util.IndentBy(indent + 1),
        }
    else
      self.Section(name, [ props ], indent)
}
