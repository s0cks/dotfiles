#!/usr/bin/env zsh

if [[ ! $+command[starship] ]]; then
  echo " Starship is not installed!  "
  return 1
fi

local init_file="$HOME/.zim/modules/zim-starship/init-starship.sh"
if [[ ! -e "$init_file" ]]; then
  starship init zsh --print-full-init >|$init_file
  zcompile -UR $init_file

  local comp_file="$HOME/.zsh_completions/_starship"
  if [[ ! -e "$comp_file" ]]; then
    starship completions zsh >|"$comp_file"
  fi
fi

source "$init_file"
