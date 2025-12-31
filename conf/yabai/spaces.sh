#!/usr/bin/env zsh

YABAI_PRIMARY_DISPLAY=${YABAI_PRIMARY_DISPLAY:=1}
YABAI_MAX_SPACES=${YABAI_MAX_SPACES:=8}

function setup_space() {
  local idx="$1"
  local name="$2"
  echo "setting up space #$idx $name...."
  local space=$(yabai -m query --spaces --space "$idx")
  if [ -z "$space" ]; then
    yabai -m space --create
  fi
  yabai -m space "$idx" --label "$name"
}

function cleanup_spaces() {
  for i in $(yabai -m query --spaces | jq ".[] | select((.display == $YABAI_PRIMARY_DISPLAY) and .index > $YABAI_MAX_SPACES).index"); do
    yabai -m space --destroy "$i"
  done
}

setup_space 1 "work"
setup_space 2 "web"
setup_space 3 "chat"
setup_space 4 "music"
setup_space 5 "other"

yabai -m rule --add app="Chrome$" space=^2
yabai -m rule --add app="Textual" space=^3
