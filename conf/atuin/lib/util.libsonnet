{
  Comment(lines):
    std.lines([
      "## %(line)s" % { line: line }
      for line in (if std.isArray(lines) then lines else [])
    ]),
}
