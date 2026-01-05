local zsh = import 'lib/zsh.libsonnet';
zsh.Comment("hashes (directory aliases)", true) +
zsh.Hashes({
  "dots": "$USER_DATA_HOME/dotfiles",
  "dls": "$HOME/Downloads",
  "projects": "$HOME/Projects",
  "cfg": "$XDG_CONFIG_HOME"
})
