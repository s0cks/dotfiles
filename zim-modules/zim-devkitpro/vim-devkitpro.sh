PLUGIN_DIR=${0:a:h}
export DEVKITPRO_HOME=/opt/devkitpro
export DEVKITPRO_PATH="${DEVKITPRO_HOME}/devkitPPC/bin:${DEVKITPRO_HOME}/tools/bin"
export DEVKITPRO_DEACTIVATE_PATH=""
export DEVKITPRO_DEACTIVATE_FPATH=()

devkitpro-activate() {
  if [[ -n "$DEVKITPRO_DEACTIVATE_PATH" ]]; then
    printf "\n\t\033[0;31m \033[0mDevkitPro is already activated!\n"
    return 1
  fi

  DEVKITPRO_DEACTIVATE_PATH="$PATH"
  DEVKITPRO_DEACTIVATE_FPATH=("$fpath")
  PATH="$DEVKITPRO_PATH:$PATH"
  fpath=("$PLUGIN_DIR/bin" "${fpath[@]}")
  autoload -Uz devkitpro-deactivate
  printf "\n\t\033[0;32m \033[0mDevkitPro activated!\n"
}
