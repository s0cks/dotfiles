#!/usr/bin/env zsh

if [[ ! $+command[thefuck] ]]; then
  echo "thefuck is not installed."
  return 1
fi

eval "$(thefuck --alias)"

__fuck() {
  local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $(fc -ln -1))"
  [[ -z $FUCK ]] && echo -n -e "\a" && return
  BUFFER=$FUCK
  zle end-of-line
}

__fuck_fuck() {
  local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $(fc -ln -1))"
  [[ -z $FUCK ]] && echo -n -e "\a" && return
  BUFFER=$FUCK
  zle end-of-line
  zle accept-line
}
zle -N __fuck
bindkey '\e\e' __fuck

zle -N __fuck_fuck
bindkey '\e\e\e' __fuck_fuck
