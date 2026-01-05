local zsh = import 'lib/zsh.libsonnet';
zsh.Comment("global aliases", true) +
zsh.GlobalAliasMap({
  "NE": "2>/dev/null",
  "NO": ">/dev/null",
  "NUL": ">/dev/null 2>&1",
  "JQ": "| jq",
  "GREP": "| grep ",
  "CP": "| cb"
})
