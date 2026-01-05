{
  Comment(lines, prefix = '#'):
    [
      "%(prefix)s %(line)s" % { prefix: prefix, line: line }
      for line in (if std.isArray(lines) then lines else [ lines ])
    ],
  WarningHeaderComment(extra = [], prefix = '#', newline_before = false, newline_after = false):
    $.WrapInOptionalNewlines($.Comment(
      [
        "*** Do not edit ***",
        "This file was auto-generated using Jsonnet",
        "  ~ @s0cks",
      ] +
      extra,
      prefix
    ), newline_before, newline_after),
  IndentBy(amt, c = ' '):
    std.repeat(c, amt * 2),
  Indent: $.IndentBy(1),
  Quote(value):
    '"' + value + '"',
  SingleQuote(value):
    "'" + value + "'",
  local NEWLINE = [ '' ],
  Optional(value, cond, default_value = []):
    if cond then
      value
    else
      default_value,
  OptionalNewline(cond, default_value = []):
    $.Optional(NEWLINE, cond, default_value),
  WrapInOptionalNewlines(value, newline_before = false, newline_after = false):
    $.OptionalNewline(newline_before) +
    value +
    $.OptionalNewline(newline_after),
}
