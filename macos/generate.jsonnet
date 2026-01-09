local brewfile = import 'lib/brewfile.libsonnet';

{
  ["defaults.sh"]: (import 'lib/macos_defaults.libsonnet'),
}
