local util = import 'lib/util.libsonnet';
{
  manifest(styles):
    std.lines(util.WarningHeaderComment()) +
    std.manifestToml(
      {
        ["styles.%(name)s" % { name: section.key }]: section.value
        for section in std.objectKeysValues(styles) 
      }
    ),
}
