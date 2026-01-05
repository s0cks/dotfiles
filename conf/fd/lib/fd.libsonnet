local util = import 'lib/util.libsonnet';

{
  Section(title, entries, newline_before = false, newline_after = false):
    util.WrapInOptionalNewlines(
      util.Comment(title) +
      entries,
      newline_before, newline_after),
  manifest(lines, include_warning = true, newline_after = false):
    std.lines(
      util.Optional(util.WarningHeaderComment(newline_after=true), include_warning) +
      std.flattenDeepArray(lines) +
      util.OptionalNewline(newline_after)
    )
}
