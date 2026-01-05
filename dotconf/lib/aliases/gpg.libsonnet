local zsh = import 'lib/zsh.libsonnet';

local PrefixAlias(name, prefix = "gpg") = prefix + name;
local GpgAlias(name, value) = zsh.Alias(PrefixAlias(name), value);
local GpgAliasMap(data) =
  [
    GpgAlias(name, data[name])
    for name in std.objectFields(data)
  ];

GpgAliasMap(import 'lib/aliases/gpg.json')
