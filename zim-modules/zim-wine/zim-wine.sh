#!/usr/bin/env zsh
PLUGIN_DIR=${0:a:h}

export WINE_HOME="${WINE_HOME:=/opt/wine}"
export fpath=("$PLUGIN_DIR/bin" "${fpath[@]}")
autoload -Uz activate-wine-prefix
autoload -Uz create-wine-prefix
