local util = import 'lib/util.libsonnet';

{
  Config(autocomplete = true, breaking_changes = true, issues = true, emoji = true, sign = true):
    {
      autocomplete: autocomplete,
      breaking_changes: breaking_changes,
      issues: issues,
      emoji: emoji,
      sign: sign,
    },
  CommitType(name, emoji, description):
    {
      name: name, 
      emoji: emoji,
      description: description,
    },
  CommitTypes(types):
    {
      commit_types: types
    },
  manifest(config):
    std.lines(util.WarningHeaderComment([], '#', false, true)) +
    std.manifestTomlEx(config, "  "),
}
