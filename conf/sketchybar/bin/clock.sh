#!/usr/bin/env zsh

DEFAULT_PATTERN="%a %b %d %H:%M"
HOVER_PATTERN="%a %b %d, %Y %H:%M"

local pattern="$DEFAULT_PATTERN"
if [[ "$SENDER" == "mouse.entered" ]]; then
  sketchybar --set "$NAME" label="$(date '+%a %b %d, %Y %H:%M')"
else
  sketchybar --set "$NAME" label="$(date '+%a %b %d %H:%M')"

fi
