{
  local SingleQuote(value) = "'" + value + "'",
  Style(cat, key, value):
    "zstyle " + SingleQuote(cat) + " " + key + " " + value,
  StyleMap(cat, data):
    [
      $.Style(cat, name, data[name])
      for name in std.objectFields(data)
    ],
}
