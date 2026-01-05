{
  local SingleQuote(value) = "'" + value + "'",
  Style(cat, key, value):
    "zstyle " + SingleQuote(cat) + " " + key + " " + value,
  StyleMap(cat, data):
    [
      $.Style(cat, name, data[name])
      for name in std.objectFields(data)
    ],
  manifest(styles):
    std.lines(std.flattenDeepArray(if std.isArray(styles) then styles else [ styles ])),
}
