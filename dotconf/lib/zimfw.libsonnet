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
    std.join(" && ", (if std.isArray(conds) then conds else [ conds ])),
  local If(cond) =
    "--if '[[ " +
    cond +
    " ]]'",
  local IfCommands(commands, op = " && ") =
    If(CombineConds([
      CommandCond(command)
      for command in (if std.isArray(commands) then commands else [ commands ])
    ], op)),
  ModuleIfCommands(name, commands, op = " && ", fpath = null, f = null, a = null):
    $.Module(name, IfCommands(commands, op), fpath, f, a),
}
