#!/usr/bin/env sh
INSTALL_PREFIX="${INSTALL_PREFIX:-/usr/local}"
DOTBOT_INSTALL_DIR="$INSTALL_PREFIX/share/dotbot"
DOTFILES_INSTALL_DIR="$INSTALL_PREFIX/share/dotfiles"

brew_install_silently() {
  brew install \
    "$@" \
    >/dev/null
}

shallow_clone() {
  git clone \
    --depth 1 \
    --shallow-submodules \
    --recurse-submodules \
    -j8 \
    "git@github.com:$1.git" \
    "$2"
}

install_dotfiles() {
  export DOTBOT_HOME="$DOTBOT_INSTALL_DIR"
  export PATH="$DOTBOT_INSTALL_DIR/bin:$PATH"
  # TODO(@s0cks): use task for this?
  dotbot -d "$DOTFILES_INSTALL_DIR/" -c "$DOTFILES_INSTALL_DIR/install.yml"
}

# 0. Login as root
sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# 1. Ensure homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
  echo "installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Install utilities using homebrew
brew_install_silently \
  git \
  eget \
  go-task/tap/go-task

# 3. Install dotbot
shallow_clone "s0cks/dotbot" "$DOTBOT_INSTALL_DIR/"
# 4. Clone dotfiles
shallow_clone "s0cks/dotfiles" "$DOTFILES_INSTALL_DIR/"
# 5. Install dotfiles using dotbot
install_dotfiles
