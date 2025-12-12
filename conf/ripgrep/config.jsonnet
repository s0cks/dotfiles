local custom_types = import "./custom_types.json";

local GenerateTypeArg(name, pattern) = |||
  # %(name)s types
  --type-add
  %(name)s:%(pattern)s
||| % {
  name: name,
  pattern: pattern
};

local GenerateConfig(types = []) = |||
  # ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐
  # ╎                          Core                           ╎
  # └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘
  # columns
  --max-columns=60
  --max-columns-preview
  # ignore case
  --smart-case
  # follow symlinks
  --follow
  # include hidden files
  --hidden
  # exclude .git directory
  --glob=!.git/*

  # ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐
  # ╎                      Custom Types                       ╎
  # └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘
  %(types)s
||| % {
  types: std.join('\n', [ GenerateTypeArg(type, types[type]) for type in std.objectFields(types) ]),
};


{
  "config": GenerateConfig(custom_types),
}
