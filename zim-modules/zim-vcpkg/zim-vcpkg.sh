#!/usr/bin/env zsh

export VCPKG_HOME="${VCPKG_ROOT:=$HOME/vcpkg/}"

autoload -U +X bashcompinit && bashcompinit
source "$VCPKG_HOME/scripts/vcpkg_completion.zsh"
