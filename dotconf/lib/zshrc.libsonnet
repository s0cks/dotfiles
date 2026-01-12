local zsh = import 'lib/zsh.libsonnet';
local util = import 'lib/util.libsonnet';
local zim = import 'lib/zimfw.libsonnet';
local OS = std.extVar("OS");
local commands = import 'lib/commands.libsonnet';

local Autoloads(newline_before = false, newline_after = false) =
  util.WrapInOptionalNewlines([
    zsh.AutoloadDir('/usr/local/share/zsh/functions'),
  ], newline_before, newline_after);

local style = import 'lib/zshrc/style.libsonnet';
local LoadStyleFragment(prefix = "$HOME") = |||
  if macos-is-light; then
  %(light_style)s
  else
  %(dark_style)s
  fi
||| % {
  light_style:
    std.join("\n", [
      util.IndentBy(1) + line
      for line in std.flattenDeepArray(style.LightStyle)
    ]),
  dark_style: 
    std.join("\n", [
      util.IndentBy(1) + line
      for line in std.flattenDeepArray(style.DarkStyle)
    ]),
};
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

local OSXConfig() = 
  zsh.Source([
    "<(luarocks path)",
    "<(pay-respects zsh)",
    "$HOME/.zsh_custom/fz.sh", // TODO(@s0cks): wtf is this?
    "$HOME/.zkeys",
    "$HOME/.zaliases",
    // "$USER_DATA_HOME/toolchains/${DEFAULT_TOOLCHAIN:-homebrew-llvm}", // TODO(@s0cks): convert this to: s0cks tc activate ${DEFAULT_TOOLCHAIN:-homebrew-llvm}
  ]) +
  LoadStyle();

local LoadStarshipFragment = 'eval "$(starship init zsh)"';
local LoadStarship() = 
  zsh.Comment("Load Starship", true) +
  std.split(LoadStarshipFragment, "\n");

local LoadMiseFragment = 'eval "$(mise activate zsh)"';
local LoadMise =
  zsh.Comment("Load mise", true) +
  std.split(LoadMiseFragment, "\n");

(if OS == "OSX" then (import 'lib/zshrc/homebrew.libsonnet') else []) +
Autoloads(false, true) +
zsh.Source([
  "$HOME/.zstyles",
]) +
zim.LoadZim() +
zsh.Source([
  "$HOME/.zkeys",
  "$HOME/.zaliases",
]) +
(if commands.hasStarship then LoadStarship() else []) +
(if commands.hasMise then LoadMise else []) +
(if OS == "OSX" then OSXConfig() else []) +
//TODO(@s0cks): remove this once these values are configured  properly using the theme
[
  '',
  "unset ZLS_COLORS",
  "unset LS_COLORS",
]
