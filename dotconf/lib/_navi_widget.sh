# vim: set ft=zsh:
__navi_widget() {
  local -r input="${LBUFFER}"
  local output="$(navi --print --fzf-overrides '--no-select-1')"

  if [[ "$output" =~ "run: "* ]]; then
    zle push-line
    LBUFFER="${output/run: /}"
    zle accept-line
  elif [[ -n "$output" ]]; then
    LBUFFER="${input}${output}"
  fi

  zle redisplay
}
