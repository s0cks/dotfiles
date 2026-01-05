local zsh = import 'lib/zsh.libsonnet';

local BatSuffixAlias(suffixes) = zsh.SuffixAlias(suffixes, "bat");
local OpenSuffixAlias(suffixes) = zsh.SuffixAlias(suffixes, "open");

BatSuffixAlias([
  "json", //TODO(@s0cks): should change this to a better jq browser
  "txt",
]) +
zsh.SuffixAlias("md", "glow") +
OpenSuffixAlias("html") + 
zsh.EditorSuffixAlias(import 'lib/source_file_extensions.json')
