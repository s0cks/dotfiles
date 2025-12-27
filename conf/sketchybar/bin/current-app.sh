#!/usr/bin/env zsh

app_name="$INFO"
if [[ "$app_name" == "wezterm-gui" ]]; then
  app_name="WezTerm"
fi

sketchybar --set current_app label="$app_name"
