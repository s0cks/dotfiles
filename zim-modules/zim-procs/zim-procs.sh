#!/usr/bin/env zsh
if [[ ! $+commands[procs] ]]; then
  echo "$fg_bold[red] $reset_color procs is not installed."
fi

if [[ ! -f "$ZSH_COMPLETIONS_DIR/_procs" ]]; then
  autoload -Uz _procs
fi

procs --gen-completion-out zsh >|"$ZSH_COMPLETIONS_DIR/_procs" &|
