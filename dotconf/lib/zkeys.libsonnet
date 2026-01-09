local zsh = import 'lib/zsh.libsonnet';
local zle = import 'lib/zle.libsonnet';
local util = import 'lib/util.libsonnet';

local GetWidgetName(name) = "__%(name)s_widget" % { name: name };
local CreateNewWidget(name, exec, newline_before = false, newline_after = false) =
  util.WrapInOptionalNewlines(
    [ GetWidgetName(name) + "() {" ] +
    [
      util.IndentBy(1) + stmt
      for stmt in (if std.isArray(exec) then exec else [ exec ])
    ] +
    [ "}"], newline_before, newline_after);

local BindWidget(binding, name, newline_before = false, newline_after = false) =
  util.WrapInOptionalNewlines([
    zsh.BindKey(binding, name),
  ], newline_before, newline_after);

local BindNewWidget(binding, name, newline_before = false, newline_after = false) =
  util.WrapInOptionalNewlines([
    zle.NewWidget(name),
    zsh.BindKey(binding, name),
  ], newline_before, newline_after);

local CreateAndBindNewWidget(binding, name, exec, newline_before = false, newline_after = false) =
  CreateNewWidget(name, exec, newline_before) +
  BindNewWidget(binding, GetWidgetName(name), false, newline_after);

local CreateAndBindNewWidgetForCommand(binding, exec, newline_before = false, newline_after = false) =
  CreateAndBindNewWidget(binding, exec, [
    exec
  ], newline_before, newline_after);

local CreateAndBindNewWidgetFromFragment(binding, name, template, newline_before = false, newline_after = false) =
  CreateAndBindNewWidget(binding, name, std.split("\n", template)[1:], newline_before, newline_after);

local CreateAndBindNewWidgetFromTemplate(binding, name, template, newline_before = false, newline_after = false) =
  util.WrapInOptionalNewlines(
    std.split(template, "\n")[1:-1] +
    BindNewWidget(binding, GetWidgetName(name)), newline_before, newline_after);

local BindMagicSpaceWidget = BindWidget(" ", "magic-space");

local EditCommandLine(newline_before = false, newline_after = false) =
  util.WrapInOptionalNewlines([
    "autoload -Uz edit-command-line",
    "zle -N edit-command-line",
    "bindkey '^E' edit-command-line",
  ], newline_before, newline_after);

[
	"for key ('^[[A' '^K' ${terminfo[kcuu1]}); bindkey ${key} history-substring-search-up",
	"for key ('^[[B' '^J' ${terminfo[kcud1]}); bindkey ${key} history-substring-search-down",
	"for key ('k'); bindkey -M vicmd ${key} history-substring-search-up",
	"for key ('j'); bindkey -M vicmd ${key} history-substring-search-down",
	"unset key",
	"unsetopt FLOW_CONTROL",
  "",
] +
BindMagicSpaceWidget +
EditCommandLine(true) +
BindNewWidget("^\\", "yz", true) +
CreateAndBindNewWidgetForCommand("^]", "lazygit", true) +
CreateAndBindNewWidgetForCommand("^[", "nvim", true) +
CreateAndBindNewWidget("^[R", "relooad_zsh", [
  "zle -I",
  "clear",
  "exec zsh <$TTY",
], true) +
CreateAndBindNewWidgetFromTemplate("^n", "navi", (importstr "lib/_navi_widget.sh"), true)
