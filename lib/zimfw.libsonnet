local util = import 'lib/util.libsonnet';

{
  Module(name, cond = null, fpath = null, f = null, a = null):
    [
      "zmodule " + name +
        (if cond != null then " --if " + cond else "") +
        (if fpath != null then " --fpath " + fpath else "") +
        (if f != null then " -f " + f else "") +
        (if a != null then " -a " + a else ""),
    ],
  local CommandCond(command) =
    "\\$+commands[%(command)s]" % { command: command },
  local CombineConds(conds, op = " && ") =
    std.join(op, (if std.isArray(conds) then conds else [ conds ])),
  local If(cond) =
    "'[[ " +
    cond +
    " ]]'",
  local IfCommands(commands, op = " && ") =
    If(CombineConds([
      CommandCond(command)
      for command in (if std.isArray(commands) then commands else [ commands ])
    ], op)),
  ModuleIfCommands(name, commands, op = " && ", fpath = null, f = null, a = null):
    $.Module(name, IfCommands(commands, op), fpath, f, a),
  Modules(names):
    [
      $.Module(module)
      for module in names
    ],
  local LoadZimFragment = |||
    ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
    source "${ZIM_HOME}/init.zsh"
    zmodload -F zsh/terminfo +p:terminfo
  |||,
  LoadZim(newline_before = false, newline_after = false):
    util.WrapInOptionalNewlines(
      util.Comment("Load zim") +
      std.split(LoadZimFragment, "\n"),
      newline_before, newline_after),
}
