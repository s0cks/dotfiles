{
  IndentBy(amt, c = ' '):
    std.repeat(c, amt * 2),
  Wrap(tag, values, indent):
    [ $.IndentBy(indent) + '<' + tag + '>' ] +
    values +
    [ $.IndentBy(indent) + '</' + tag + '>' ],
  Dict(props, indent = 1):
    $.Wrap('dict', props, indent),
  Array(values, indent = 1):
    $.Wrap('array', values, indent),
  Key(k, indent = 2):
    $.IndentBy(indent) + '<key>' + k + '</key>',
  String(v, indent = 2):
    $.IndentBy(indent) + '<string>' + v + '</string>',
  StringProperty(key, value, indent = 2):
    [
      $.Key(key, indent),
      $.String(value, indent),
    ],
  Bool(value, indent = 2):
    $.IndentBy(indent) + '<' + value + '/>',
  BoolProperty(key, value, indent = 2):
    [
      $.Key(key, indent),
      $.Bool(value, indent),
    ],
  RunAtLoad(value = true, indent = 2):
    $.BoolProperty('RunAtLoad', value, indent),
  KeepAlive(value = true, indent = 2):
    $.BoolProperty('KeepAlive', value, indent),
  WorkingDirectory(value, indent = 2):
    $.StringProperty('WorkingDirectory', value, indent),
  StandardOutPath(value, indent = 2):
    $.StringProperty('StandardOutPath', value, indent),
  StandardErrPath(value, indent = 2):
    $.StringProperty('StandardErrPath', value, indent),
  Label(value, indent = 2):
    $.StringProperty('Label', value, indent),
  EnvironmentVariables(env, indent = 2):
    [
      $.Key("EnvironmentVariables", indent),
      $.Dict([
        [
          $.Key(k, indent + 1),
          env[k],
        ]
        for k in std.objectFields(env)
      ], indent),
    ],
  ProgramArguments(args, indent = 2):
    [
      $.Key("ProgramArguments", indent),
      $.Array(args, indent),
    ],
  manifest(props):
    std.lines(std.flattenDeepArray(
      [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
        '<plist version="1.0">',
      ] +
      $.Dict(props) +
      [
        '</plist>'
      ]
    ))
}
