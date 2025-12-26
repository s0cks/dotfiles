#!/usr/bin/env zsh
#TODO(@s0cks): make sh compatible / remove zsh dependency
autoload -Uz colors && colors

INSTALL_PREFIX="/usr/local"
echo "installing dotbot and plugins...."
DOTBOT_DIR="$INSTALL_PREFIX/share/dotbot"
DOTBOT_PLUGIN_INSTALL_DIR="$DOTBOT_DIR/plugins"
DOTBOT_REPO="https://github.com/anishathalye/dotbot.git"
DOTBOT_PLUGINS=(
  "https://github.com/wren/dotbot-brew.git"
  "https://github.com/fundor333/dotbot-gh-extension.git"
  "https://github.com/DrDynamic/dotbot-git.git"
  "https://github.com/s0cks/dotbot-if.git"
  "https://github.com/s0cks/dotbot-includes.git"
  "https://github.com/s0cks/dotbot-jsonnet.git"
  "https://github.com/s0cks/dotbot-mise.git"
  "https://github.com/s0cks/dotbot-ya.git"
  "https://github.com/s0cks/dotbot-watchman.git"
  "https://github.com/s0cks/dotbot-tera.git"
)
DOTBOT_EXEC="$DOTBOT_DIR/bin/dotbot"
DOTBOT_EXEC_WRAPPER="$INSTALL_PREFIX/bin/dotbot"

local function shallow_clone_with_submodules() {
  git clone \
    --depth 1 \
    --shallow-submodules \
    --recurse-submodules \
    -j8 \
    "$1"
}

local function clone_dotbot_and_plugins() {
}


local function gen_exec_wrapper() {
  dotbot_plugins_flags=""
  for plugin in "$DOTBOT_PLUGIN_INSTALL_DIR/"*; do
    dotbot_plugins_flags="$dotbot_plugins_flags -p $plugin"
  done

  read -r -d '' DOTBOT_EXEC_WRAPPER_SCRIPT <<EOF
#!/usr/bin/env sh
$DOTBOT_EXEC \
  --verbose \
  $dotbot_plugins_flags \
  --exit-on-failure \
  "\$@"
EOF

  echo "$DOTBOT_EXEC_WRAPPER_SCRIPT" > "$DOTBOT_EXEC_WRAPPER"
  chmod +x "$DOTBOT_EXEC_WRAPPER"
}


if [[ ! -d "$DOTBOT_DIR" ]]; then
  # clone dotbot itself
  cd "$INSTALL_PREFIX/share/"
  shallow_clone_with_submodules "$DOTBOT_REPO"
  cd "$DOTBOT_DIR/"
else
  cd "$DOTBOT_DIR/"
  git pull --recurse-submodules
fi

if [[ ! -d "$DOTBOT_PLUGIN_INSTALL_DIR/" ]]; then
  mkdir -p "$DOTBOT_PLUGIN_INSTALL_DIR/" && cd "$DOTBOT_PLUGIN_INSTALL_DIR/"
  for plugin in "${DOTBOT_PLUGINS[@]}"; do
    shallow_clone_with_submodules "$plugin"
  done
else
  cd "$DOTBOT_PLUGIN_INSTALL_DIR/"
  for plugin in "$DOTBOT_PLUGIN_INSTALL_DIR/"*; do
    cd "$plugin"
    git pull --recurse-submodules
  done
fi

if [[ ! -f "$DOTBOT_EXEC_WRAPPER" ]]; then
  gen_exec_wrapper
fi
