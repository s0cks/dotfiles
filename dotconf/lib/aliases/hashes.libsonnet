local zsh = import 'lib/zsh.libsonnet';
zsh.Comment("hashes (directory aliases)", true) +
zsh.Hashes({
  "ots": "$USER_DATA_HOME/dotfiles",
  "ls": "$HOME/Downloads",
  "rojects": "$HOME/Projects",
  "fg": "$XDG_CONFIG_HOME"
})
