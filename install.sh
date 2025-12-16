#!/usr/bin/env sh
# 1. Install homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed, skipping"
fi

# 2. Install git using homebrew
brew install git

# 3. Clone @s0cks/dotfiles from GitHub
#TODO(@s0cks): make shallow clone of HEAD
git clone https://github.com/s0cks/dotfiles.git &&
  cd "dotfiles/" || exit

# 4. Install Brewfile
brew bundle

# 4. Run install using task
task default

# TODO(@s0cks):
# 5. generate install summary to user home directory and open it in explorer
