local cava = import 'lib/cava.libsonnet';
local flexoki = import 'lib/flexoki.libsonnet';

{
  ["config"]: cava.Config({
    "general": cava.General(),
    "input": cava.PortAudioInput(),
    "output": cava.NcursesOutput(),
    "eq": cava.Eq(),
    "smoothing": cava.Smoothing(),
    "color": cava.Gradient(flexoki.Dark.rainbow() + [ flexoki.Dark.ma ]),
  }),
}
