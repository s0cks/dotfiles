local util = import 'lib/util.libsonnet';

{
  manifest(config):
    std.lines(util.WarningHeaderComment([], "#", false, true)) +
    std.manifestTomlEx(config, '  '),
}
