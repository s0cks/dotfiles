local zsh = import 'lib/zsh.libsonnet';
local util = import 'lib/util.libsonnet';
local zim = import 'lib/zimfw.libsonnet';

local StripLinesFromFront(fragment, n) =
  std.split(fragment, "\n")[n:];
local StripLinesFromBack(fragment, n) =
  std.split(fragment, "\n")[:n];

local Autoloads(newline_before = false, newline_after = false) =
  util.WrapInOptionalNewlines([
    zsh.AutoloadDir('/usr/local/share/zsh/functions'),
  ], newline_before, newline_after);


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

//TODO(@s0cks): remove
local Zeit = |||
  if [[ $+command[zeit] ]]; then
    ZEIT_COMPLETIONS_FILE="${ZSH_COMPLETIONS_DIR:-$USER_DATA_HOME/zsh/completions/_zeit}"
    if [[ ! -f "$ZEIT_COMPLETIONS_FILE" ]]; then
      zeit completion zsh > "$ZSH_COMPLETIONS_FILE"
    fi
  fi
|||;

(import 'lib/zshrc-homebrew.libsonnet') +
Autoloads(false, true) +
[
  zsh.Source("$HOME/.zstyles"),
] +
zim.LoadZim() +
[
  zsh.Source([
    "<(luarocks path)",
    "<(pay-respects zsh)",
    "$HOME/.zsh_custom/fz.sh", // TODO(@s0cks): wtf is this?
    "$HOME/.zkeys",
    "$HOME/.zaliases",
    "$USER_DATA_HOME/toolchains/${DEFAULT_TOOLCHAIN:-homebrew-llvm}", // TODO(@s0cks): convert this to: s0cks tc activate ${DEFAULT_TOOLCHAIN:-homebrew-llvm}
  ]),
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
