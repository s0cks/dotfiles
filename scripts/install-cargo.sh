#!/usr/bin/env zsh
local SCRIPT_DIR="${0:a:h}"
if [[ ! -f "Cargofile" ]]; then
  echo "no Rustfile found in ${0:a:h}."
  return 1
fi

typeset -a targets
targets=("${(@f)$(<Cargofile)}")
cargo install ${targets[@]}
