local zsh = import 'lib/zsh.libsonnet';
zsh.Comment("editor aliases", true) +
zsh.Alias([
  "e",
  "edit",
  "vi",
  "vim",
  "nvim"
], 'editz')
