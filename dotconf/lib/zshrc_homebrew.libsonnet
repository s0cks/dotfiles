local util = import 'lib/util.libsonnet';
local zsh = import 'lib/zsh.libsonnet';

local ExportBrewPathPrepend(prefix = null, path = "/bin") =
  zsh.ExportPathPrepend("$(%(prefix_cmd)s)%(path)s" % {
    prefix_cmd: "brew --prefix" + (if prefix != null then " " + prefix else ""),
    path: path,
  });

local BREW_PREFIX_ARM64 = "/opt/homebrew";
local BREW_PREFIX_X86 = "/usr/local";
local LoadHomebrewFragment = |||
  if [[ "$(arch)" == "arm64" ]]; then
    eval "$(%(arm64)s/bin/brew shellenv)"
  elif [[ "$(arch)" == "x86_64" || "$(arch)" == "i386" ]]; then
    eval "$(%(x86)s/bin/brew shellenv)"
  else
    echo "invalid archiecture: $(arch)"
    return 1
  fi
||| % {
  arm64: BREW_PREFIX_ARM64,
  x86: BREW_PREFIX_X86,
};
local LoadHomebrew() =
  util.Comment("Load Homebrew") +
  std.split(LoadHomebrewFragment, "\n");

LoadHomebrew() +
util.WrapInOptionalNewlines([
  ExportBrewPathPrepend(),
  ExportBrewPathPrepend("llvm"),
  ExportBrewPathPrepend("coreutils", "/libexec/gnubin"),
], false, true)
