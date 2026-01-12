local util = import 'lib/util.libsonnet';

{
  local RawValue(value) =
    if std.isArray(value) then
      [ '[' ] +
      (if std.length(value) > 1 then
        [
          util.IndentBy(1) + RawValue(v) + ", "
          for v in std.slice(value, 0, std.length(value) - 1, 1)
        ] +
        [
          value[std.length(value)]
        ]
      else
        [ util.IndentBy(1) + RawValue(value[0]) ]) +
      [ ']' ]
    else
      if std.isString(value) then
        util.Quote(value)
      else
        value,
  local PrefixValue(prefix, value) =
    std.flattenDeepArray([
      prefix + ' ' + value[0],
    ] +
    (if std.length(value) > 1 then std.slice(value, 1, std.length(value), 1) else [])),
  Define(name, value):
    PrefixValue('.define ' + name, RawValue(value)),
  local NEWLINE = "\\\\",
  local Combinator(op) = " " + op + " ",
  DefineCommand(name, cmd, combin = " || "):
    if std.isArray(cmd) then
      [ '.define ' + name + " : " + NEWLINE ] +
      [
        util.IndentBy(1) + c + Combinator(combin) + NEWLINE
        for c in (if std.length(cmd) > 1 then std.slice(cmd, 0, std.length(cmd) - 1, 1) else cmd)
      ] +
      (if std.length(cmd) > 1 then [ util.IndentBy(1) + cmd[std.length(cmd) - 1] ] else [])
    else
      [ PrefixValue(".define " + name + " : ", [ cmd ]) ],
  Blacklist(value, newline_before = false, newline_after = false):
    $.Section('Blacklist', [
      PrefixValue('.blacklist', RawValue(value))
    ], newline_before, newline_after),
  Bind(mod, key, cmd, combin = "||"):
    "%(mod)s - %(key)s : %(cmd)s" % {
      mod: (if std.isArray(mod) then std.join("+", mod) else mod),
      key: key,
      cmd: (if std.isArray(cmd) then std.join(Combinator(combin), cmd) else cmd),
    },
  BindCall(mod, key, func, args = []):
    $.Bind(mod, key, '@%(func)s(%(args)s)' % {
      func: func,
      args: std.join(', ', [
        util.Quote(arg)
        for arg in (if std.isArray(args) then args else [ args ])
      ]),
    }),
  Load(path): ".load " + util.Quote(path),
  Section(name, values, newline_before = false, newline_after = false):
    util.WrapInOptionalNewlines(
      util.Comment(name) +
      values, newline_before, newline_after),
  manifest( blacklist = [], extras = []):
    std.lines(std.flattenDeepArray(
      util.WarningHeaderComment([], "#", false, true) +
      $.Blacklist(blacklist, false, true) +
      extras
    )),
}
