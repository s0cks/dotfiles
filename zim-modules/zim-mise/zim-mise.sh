#!/usr/bin/env zsh
PLUGIN_DIR="${0:a:h}"

if [[ ! $+commands[mise] ]]; then
  echo "$fg_bold[red] $fg_color[cyan]mise$reset_color is not installed."
  return 1
fi

source <(mise activate zsh)
source <(mise hook-env -s zsh)

if [[ ! -f "$ZSH_COMPLETIONS_DIR/_mise" ]]; then
  autoload -Uz _mise
fi

export fpath=("$PLUGIN_DIR/bin" "${fpath[@]}")
if [[ $+commands[fzf] ]]; then
  autoload -Uz fzmisels
  autoload -Uz fzmisels-remote
fi

export fpath=("$PLUGIN_DIR/bin" "${fpath[@]}")

mise completions zsh >| "$ZSH_COMPLETIONS_DIR/_mise" &|
