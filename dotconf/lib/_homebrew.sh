# vim: set ft=zsh:

if [[ "$(arch)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(arch)" == "x86_64" || "$(arch)" == "i386" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  echo "invalid archiecture: $(arch)"
  return 1
fi
