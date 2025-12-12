#!/usr/bin/env zsh

if [[ $+commands[bat] ]]; then
  if [[ -z "$FZF_FINDER_CAT" ]]; then
    FZF_FINDER_CAT='bat --color always {}'
  fi

  if [[ -z $FZF_FINDER_PAGER ]]; then
    FZF_FINDER_PAGER="bat"
  fi
else
  if [[ -z "$FZF_FINDER_CAT" ]]; then
    FZF_FINDER_CAT="cat {}"
  fi

  if [[ -z $FZF_FINDER_PAGER ]]; then
    FZF_FINDER_PAGER="less"
  fi
fi

fzf-finder-find() {
  if [[ $+commands[fd] ]]; then
    if [[ -n $FZF_FINDER_FD_OPTS ]]; then
      FINDER_OPTS=$FZF_FINDER_FD_OPTS
    else
      FINDER_OPTS='-t f'
    fi
    $commands[fd] $(echo $FINDER_OPTS)
  else
    if [[ $+FZF_FINDER_FIND_OPTS ]]; then
      FINDER_OPTS=$FZF_FINDER_FIND_OPTS
    else
      FINDER_OPTS="-type f -not -path './.git/*\'"
    fi
    find * $(echo $FINDER_OPTS)
  fi
}

fzf-finder-widget-editor() {
  local target
  target="$(
    fzf-finder-find |
      fzf -1 -0 \
        --no-sort \
        --ansi \
        --reverse \
        --toggle-sort=ctrl-r \
        --preview $FZF_FINDER_CAT
  )" &&
    ${FZF_FINDER_EDITOR:-${EDITOR:-vim}} "${target}"
  local ret=$?
  zle reset-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}

fzf-finder-widget-pager() {
  local target
  target="$(
    fzf-finder-find |
      fzf -1 -0 \
        --no-sort \
        --ansi \
        --reverse \
        --toggle-sort=ctrl-r \
        --preview $FZF_FINDER_CAT
  )"
  ${FZF_FINDER_PAGER} "${target}"
  local ret=$?
  zle reset-prompt
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}

zle -N fzf-finder-widget-editor
bindkey ${FZF_FINDER_EDITOR_BINDKEY:-'^e'} fzf-finder-widget-editor

zle -N fzf-finder-widget-pager
bindkey ${FZF_FINDER_PAGER_BINDKEY:-'^l'} fzf-finder-widget-pager
