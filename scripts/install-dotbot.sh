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
)
DOTBOT_EXEC="$DOTBOT_DIR/bin/dotbot"
DOTBOT_EXEC_WRAPPER="$INSTALL_PREFIX/bin/dotbot"

if [[ -f "$DOTBOT_EXEC_WRAPPER" ]]; then
  echo "$DOTBOT_EXEC_WRAPPE already exists, cannot install"
  return 1
fi

local function shallow_clone_with_submodules() {
  git clone \
    --depth 1 \
    --shallow-submodules \
    --recurse-submodules \
    -j8 \
    "$1"
}

# clone dotbot itself
cd "$INSTALL_PREFIX/share/"
shallow_clone_with_submodules "$DOTBOT_REPO"

# clone required dotbot plugins
mkdir -p dotbot/plugins/ && cd dotbot/plugins/
for plugin in "${DOTBOT_PLUGINS[@]}"; do
  shallow_clone_with_submodules "$plugin"
done

# generate executable script
#TODO(@s0cks): this is kinda a hack, should probably figure a better solution out

read -r -d '' DOTBOT_EXEC_WRAPPER_SCRIPT <<EOF
#!/usr/bin/env sh
$DOTBOT_EXEC \
  --verbose \
  -p "${DOTBOT_PLUGIN_INSTALL_DIR}/dotbot-mise" \
  -p "${DOTBOT_PLUGIN_INSTALL_DIR}/dotbot-brew" \
  -p "${DOTBOT_PLUGIN_INSTALL_DIR}/dotbot-git" \
  -p "${DOTBOT_PLUGIN_INSTALL_DIR}/dotbot-if" \
  -p "${DOTBOT_PLUGIN_INSTALL_DIR}/dotbot-ya" \
  -p "${DOTBOT_PLUGIN_INSTALL_DIR}/dotbot-jsonnet" \
  -p "${DOTBOT_PLUGIN_INSTALL_DIR}/dotbot-gh-extension" \
  -p "${DOTBOT_PLUGIN_INSTALL_DIR}/dotbot-includes" \
  -p "${DOTBOT_PLUGIN_INSTALL_DIR}/dotbot-watchman" \
  --exit-on-failure \
  "\$@"
EOF

echo "$DOTBOT_EXEC_WRAPPER_SCRIPT" > "$DOTBOT_EXEC_WRAPPER"
chmod +x "$DOTBOT_EXEC_WRAPPER"
