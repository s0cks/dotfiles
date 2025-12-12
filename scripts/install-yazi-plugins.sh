#!/usr/bin/env zsh
autoload -Uz colors && colors

ya_add_silently() {
  pkg_name="$1"
  if $(ya pkg list | grep "$pkg_name" &>/dev/null); then
    echo "$fg[green] $fg_bold[white]$pkg_name ${reset_color}is already installed, skipping"
    return 0
  fi

  ya pkg add "$pkg_name" &>/dev/null
  if (($? == 0)); then
    echo "$fg[green] $fg_bold[white]$pkg_name$reset_color installed"
  else
    echo "$fg[red] $fg_bold[white]$pkg_name$reset_color failed to install"
  fi
}

if [[ ! $+commands[yazi] ]]; then
  echo "$fg_bold[white]Yazi$reset_color is not installed"
  return 1
fi

echo "installing $fg_bold[white]yazi$reset_color plugins..."
ya_add_silently Rolv-Apneseth/starship
ya_add_silently gosxrgxx/flexoki-dark
ya_add_silently gosxrgxx/flexoki-light
