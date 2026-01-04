#!/usr/bin/env zsh
#
#TODO(@s0cks): make sh compatible / remove zsh dependency
autoload -Uz colors && colors

INSTALL_PREFIX="/usr/local/share"
DOTBOT_INSTALL_DIR="$INSTALL_PREFIX/dotbot"

if [[ ! -d "$DOTBOT_INSTALL_DIR/" ]]; then
  echo "installing dotbot...."
  git clone \
    --depth 1 \
    --shallow-submodules \
    --recurse-submodules \
    -j8 \
    git@github.com:s0cks/dotbot.git \
    "$DOTBOT_INSTALL_DIR"
  ln -sf "$DOTBOT_INSTALL_DIR/bin/dotbot" "/usr/local/bin/"
fi
