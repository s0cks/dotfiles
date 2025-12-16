local GenerateTypeArg(name, pattern) = |||
  # %(name)s types
  --type-add
  %(name)s:%(pattern)s
||| % {
  name: name,
  pattern: pattern
};

local GenerateConfig(types = []) =
  (importstr './_config') % {
    types: std.join('\n', [
      GenerateTypeArg(type, types[type])
      for type in std.objectFields(types)
    ]),
  };


{
  "config": GenerateConfig((import './custom_types.json')),
}
