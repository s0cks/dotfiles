#!/usr/bin/env zsh

__zsh_on_chpwd() {
  if [[ "$PWD" == "$HOME" ]]; then
    emulate -L zsh
    eza -la
  fi

  local ZSH_DOTENV_FILE=".env"
  if [[ -f "$ZSH_DOTENV_FILE" ]]; then
    zsh -fn "$ZSH_DOTENV_FILE" || {
      echo "dotenv: error when sourcing '$ZSH_DDTENV_FILE' file" >&2
      return 1
    }

    setopt localoptions allexport
    source "$ZSH_DOTENV_FILE"
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd __zsh_on_chpwd
