{
  Comment(lines, prefix = '#'):
    [
      "%(prefix)s %(line)s" % { prefix: prefix, line: line }
      for line in (if std.isArray(lines) then lines else [ lines ])
    ],
  IndentBy(amt, c = ' '):
    std.repeat(c, amt * 2),
  Indent: $.IndentBy(1),
}
