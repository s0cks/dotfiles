local zsh = import 'lib/zsh.libsonnet';
local PrefixAlias(name, prefix = "gpg") = prefix + name;
local GpgAlias(name, value) = zsh.Alias(PrefixAlias(name), value);
local GpgAliasMap(data) =
  [
    GpgAlias(name, data[name])
    for name in std.objectFields(data)
  ];

zsh.Comment("gpg Aliases", true) +
GpgAliasMap({
  "ep": "gpg -r $GPG_ID --armor --export",
  "epcb": "gpgep CP",
  "lk": "gpg --list-keys --keyid-format LONG",
  "lsk": "gpg --list-secret-keys --keyid-format LONG"
})
