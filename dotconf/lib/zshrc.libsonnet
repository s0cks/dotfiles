local zsh = import 'lib/zsh.libsonnet';

local StripLinesFromFront(fragment, n) =
  std.split(fragment, "\n")[n:];
local StripLinesFromBack(fragment, n) =
  std.split(fragment, "\n")[:n];

local ConfigHomebrew =
  StripLinesFromFront((importstr 'lib/_homebrew.sh'), 1) +
  [
    zsh.ExportPathPrepend("$(brew --prefix)/bin"),
    zsh.ExportPathPrepend("$(brew --prefix llvm)/bin"),
    zsh.ExportPathPrepend("$(brew --prefix coreutils)/libexec/gnubin"),
    ' ',
  ];
local Autoloads = 
  [
    "autoload -Uz colors && colors",
    "autoload -Uz /usr/local/share/zsh/functions/*(:t)",
    ' ',
  ];
local EditCommandLine = 
  [
    "autoload -Uz edit-command-line",
    "zle -N edit-command-line",
    "bindkey '^E' edit-command-line",
    ' ',
  ];

ConfigHomebrew +
Autoloads +
EditCommandLine +
[
  zsh.Source("$HOME/.zstyles"),
] +
StripLinesFromFront((importstr "lib/_load-zim.sh"), 1) +
[
  zsh.Source("$HOME/.zsh_custom/fz.sh"), //TODO(@s0cks): wtf is this?
  zsh.Source("$HOME/.zkeys"),
  zsh.Source("$HOME/.zaliases"),
  zsh.Source("<(pay-respects zsh)"),
  //TODO(@s0cks): convert this to: s0cks tc activate ${DEFAULT_TOOLCHAIN:-homebrew-llvm}
  zsh.Source("$USER_DATA_HOME/toolchains/${DEFAULT_TOOLCHAIN:-homebrew-llvm}"),
  zsh.SourceIfCommand("<(luarocks path)", "luarocks"),
] +
StripLinesFromFront((importstr 'lib/_styles.sh'), 1) +
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
