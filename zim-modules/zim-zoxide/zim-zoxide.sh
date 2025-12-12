#!/usr/bin/env zsh

if [[ ! $+command[zoxide] ]]; then
  echo "zoxide is not installed.  "
  return 1
fi

eval "$(zoxide init zsh)"
