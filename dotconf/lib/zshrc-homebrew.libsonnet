local zsh = import 'lib/zsh.libsonnet';
local util = import 'lib/util.libsonnet';

local BREW_PREFIX_X86 = "/usr/local";
local BREW_PREFIX_ARM64 = "/opt/homebrew";
local LoadHomebrewFragment = |||
  case "$(arch)" in
    arm64)
      eval "$(%(arm64)s/bin/brew shellenv)"
      ;;
    x86_64|i386)
      eval "$(%(x86)s/bin/brew shellenv)"
      ;;
    *)
      echo "invalid archiecture: $(arch)"
      return 1
      ;;
  esac
||| % {
  arm64: BREW_PREFIX_ARM64,
  x86: BREW_PREFIX_X86,
};
local LoadHomebrew(newline_before = false, newline_after = false) =
  util.WrapInOptionalNewlines(
    util.Comment("Load Homebrew") +
    std.split(LoadHomebrewFragment, "\n"),
    newline_before, newline_after);

local LoadHomebrewPaths(paths, newline_before = false, newline_after = false) = 
  util.WrapInOptionalNewlines(
    util.Comment("Load Homebrew Paths") +
    paths,
    newline_before, newline_after);

LoadHomebrew() +
LoadHomebrewPaths(
  zsh.ExportPathPrepend([
    util.BrewPrefixPath(),
    util.BrewPrefixPath('llvm'),
    util.BrewPrefixPath('coreutils', '/libexec/gnubin'),
  ]), false, true)
