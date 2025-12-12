#!/usr/bin/env zsh

tool="${SCREENCAPTURE_TOOL:-screencapture}"
plugin_dir=${0:a:h}

alias capC="${tool} -c"
alias capiC="${tool} -i -c"
alias capiwC="${tool} -i -w -c"

fpath=("$plugin_dir/bin" "${fpath[@]}")
autoload -Uz cap
autoload -Uz capi
autoload -Uz capiw
