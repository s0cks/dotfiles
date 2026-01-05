local zsh = import 'lib/zsh.libsonnet';

local BatSuffixAlias(suffixes) = zsh.SuffixAlias(suffixes, "bat");
local OpenSuffixAlias(suffixes) = zsh.SuffixAlias(suffixes, "open");

zsh.Comment("suffix aliases", true) +
BatSuffixAlias([
  "json", //TODO(@s0cks): should change this to a better jq browser
  "txt",
]) +
zsh.SuffixAlias("md", "glow") +
OpenSuffixAlias("html") + 
zsh.EditorSuffixAlias([
  "go",
  "rs",
  "py",
  "js",
  "ts",
  "java",
  "scala",
  "c",
  "h",
  "cc",
  "cpp",
  "cxx",
  "hh",
  "hpp",
  "hxx",
  "yml",
  "yaml",
  "jsonnet",
  "libsonnet"
])
