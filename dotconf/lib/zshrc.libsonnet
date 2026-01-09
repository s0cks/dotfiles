local zsh = import 'lib/zsh.libsonnet';
local util = import 'lib/util.libsonnet';

local StripLinesFromFront(fragment, n) =
  std.split(fragment, "\n")[n:];
local StripLinesFromBack(fragment, n) =
  std.split(fragment, "\n")[:n];

local Autoloads(newline_before = false, newline_after = false) =
  util.WrapInOptionalNewlines([
    zsh.AutoloadDir('/usr/local/share/zsh/functions'),
  ], newline_before, newline_after);

local LoadZimFragment = |||
  ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
  source "${ZIM_HOME}/init.zsh"
  zmodload -F zsh/terminfo +p:terminfo
|||;
local LoadZim() = 
  util.Comment("Load zim") +
  std.split(LoadZimFragment, "\n");

local LoadStyleFragment(prefix = "$HOME") = |||
  if macos-is-light; then
    source "%(prefix)s/.zshrc-light"
  else
    source "%(prefix)s/.zshrc-dark"
  fi
||| % { prefix: prefix };
local LoadStyle(prefix = "$HOME") =
  util.Comment("Load style") +
  std.split(LoadStyleFragment(prefix), "\n");

(import 'lib/zshrc_homebrew.libsonnet') +
Autoloads(false, true) +
[
  zsh.Source("$HOME/.zstyles"),
] +
LoadZim() +
[
  zsh.Source("<(pay-respects zsh)"),
  zsh.SourceIfCommand("<(luarocks path)", "luarocks"),
  zsh.Source("$HOME/.zsh_custom/fz.sh"), //TODO(@s0cks): wtf is this?
  zsh.Source("$HOME/.zkeys"),
  zsh.Source("$HOME/.zaliases"),
  //TODO(@s0cks): convert this to: s0cks tc activate ${DEFAULT_TOOLCHAIN:-homebrew-llvm}
  zsh.Source("$USER_DATA_HOME/toolchains/${DEFAULT_TOOLCHAIN:-homebrew-llvm}"),
] +
LoadStyle() +
[
  //TODO(@s0cks): remove this once these values are configured  properly using the theme
  "unset ZLS_COLORS",
  "unset LS_COLORS",
]

// #TODO(@s0cks): is this necessary?
// if (( $+command[docker] )); then
//   fpath=("$HOME/.docker/completions" $fpath)
// fi
//
