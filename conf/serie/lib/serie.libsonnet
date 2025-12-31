
{
  IndentBy(amt, c = ' '):
    std.repeat(c, amt * 2),
  Indent: $.IndentBy(1),
  Config(value):
    std.manifestTomlEx(value, $.Indent),
}
