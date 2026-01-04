#!/usr/bin/env sh
INSTALL_PREFIX="${INSTALL_PREFIX:-/usr/local/share}"
DOTBOT_INSTALL_DIR="$INSTALL_PREFIX/dotbot"
DOTFILES_INSTALL_DIR="$INSTALL_PREFIX/dotfiles"

# 1. Ensure Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
  echo "installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Install utilities
brew install \
  git \
  go-task/tap/go-task

shallow_clone() {
  git clone \
    --depth 1 \
    --shallow-submodules \
    --recurse-submodules \
    -j8 \
    "git@github.com:$1.git" \
    "$2"
}

# 3. Install dotbot
shallow_clone "s0cks/dotbot" "$DOTBOT_INSTALL_DIR/"

# 4. Clone & Install dotfiles
shallow_clone "s0cks/dotfiles" "$DOTFILES_INSTALL_DIR/"
export DOTBOT_HOME="$DOTBOT_INSTALL_DIR"
export PATH="$DOTBOT_INSTALL_DIR/bin:$PATH"
# TODO(@s0cks): use task for this?
dotbot -d "$DOTFILES_INSTALL_DIR/" -c "$DOTFILES_INSTALL_DIR/install.yml"
