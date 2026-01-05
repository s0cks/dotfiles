local bat = import 'lib/bat.libsonnet';

{
  ["config"]:
    bat.manifest([
      bat.Theme("Flexoki"),
      bat.AlwaysPaging,
      bat.LessPager,
    ]),
}
