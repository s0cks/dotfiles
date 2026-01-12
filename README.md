# Dotfiles v2

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Installation](#installation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

1. Install homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install dotbot


3. Run dotbot

## Installation Overview

Once dotbot is ran it will do the following things:

1. Create some default directories
2. Install mise & mise configured tools
3. Generate the following configurations using Jsonnet:
    - git
    - ssh
    - [ripgrep](https://github.com/BurntSushi/ripgrep)
    - [aria2](https://github.com/aria2/aria2)
4. Clone the following git repositories:
    - [@microsoft/vcpkg](https://github.com/microsoft/vcpkg)
    - [@s0cks/cheats](https://github.com/s0cks/cheats)
5. Install various shell scripts to: `/usr/local/share/zsh/functions/`
6. Install various configs to: `~/.config/`
7. Install various zim modules to: `~/.zim/modules/`
8. Install various dotfiles to: `~/`
9. Install plugins and themes for [@sxyazi/yazi](https://github.com/sxyazi/yazi)
10. Install OS specific configs. See [macos/](macos/README.md)
11. Generate instllation summary in ~/Installation Summary.md
