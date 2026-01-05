local zsh = import 'lib/zsh.libsonnet';
local env = import 'lib/env.libsonnet';
local source_file_extensions = import 'source_file_extensions.json';



// eza
// local eza_params=(
//   '--git' '--icons' '--group' '--group-directories-first'
//   '--time-style=long-iso' '--color-scale=all' '--color'
// )
// [[ ! -z $_EZA_PARAMS ]] && eza_params=($_EZA_PARAMS)
//
// alias ls="eza --group-directories-first ${(j: :)_EZA_PARAMS} $@"
// alias l="eza --git-ignore --group-directories-first ${(j: :)_EZA_PARAMS}"
// alias ll="eza --all --header --long --group-directories-first ${EZA_PARAMS}"
// alias llm="eza --all --header --long --sort=modified --group-directories-first ${_EZA_PARAMS}"
// alias la='eza -lbhHigUmuSa'
// alias lx='eza -lbhHigUmuSa@'
// alias lt='eza --tree $eza_params'

local BatSuffixAlias(suffix) = zsh.SuffixAlias(suffix, "bat");
local OpenSuffixAlias(suffix) = zsh.SuffixAlias(suffix, "open");
local SuffixAliases =
  [
    BatSuffixAlias("json"), //TODO(@s0cks): should change this to a better jq browser
    BatSuffixAlias("txt"),
    zsh.SuffixAlias("md", "glow"),
    OpenSuffixAlias("html"),
  ] +
  [
    zsh.EditorSuffixAlias(suffix)
    for suffix in source_file_extensions
  ];
local GlobalAliases =
  [
    zsh.GlobalAlias("NE", "2>/dev/null"),
    zsh.GlobalAlias("NO", ">/dev/null"),
    zsh.GlobalAlias("NUL", ">/dev/null 2>&1"),
    zsh.GlobalAlias("JQ", "| jq"),
    zsh.GlobalAlias("GREP", "| grep "),
    zsh.GlobalAlias("CP", "| cb"),
  ];
local hashes = {
  dots: "$USER_DATA_HOME/dotfiles",
  dls: "$HOME/Downloads",
  projects: "$HOME/Projects",
  cfg: "$XDG_CONFIG_HOME",
};
local Hashes =
  [
    zsh.HashDir(name, hashes[name])
    for name in std.objectFields(hashes)
  ];

local EditzAlias(key) = zsh.Alias(key, "editz");
local EditorAliases =
  [
    EditzAlias(name)
    for name in [
      "e",
      "edit",
      "vi",
      "vim",
      "nvim",
    ]
  ];
local GpgAliases =
  [
    zsh.Alias("gpgep", "gpg -r $GPG_ID --armor --export"),
    zsh.Alias("gpglk", "gpg --list-keys --keyid-format LONG"),
    zsh.Alias("gpglsk", "gpg --list-secret-keys --keyid-format LONG"),
    zsh.Alias("gpgepcb", "gpgep | cb"),
  ];
local MiscAliases =
  [
    zsh.Alias("organize-test", "organize sim --tags=debug --skip-tags=slow --working-dir=$HOME"),
    zsh.Alias("afk", "open /System/Library/CoreServices/ScreenSaverEngine.app"),
    zsh.Alias("home", "cd ~"),
    zsh.Alias("chrome", "open -a /Applications/Google\\ Chrome.app"),
    zsh.Alias("drive", "open -a /Applications/Google\\ Drive.app"),
    zsh.Alias("sheets", "open -a /Applications/Google\\ Sheets.app"),
    zsh.Alias("task-dry", "task --dry"),
    zsh.Alias("emoji", "emoji_fzf"),
    zsh.Alias("tetris", "tetrs_tui"),
    zsh.Alias("tail", "btail"),
    zsh.Alias("neofetch", "fastfetch"),
    zsh.Alias("port-scan", "rustscan"),
    zsh.Alias("weather", "https -b 'wttr.in?format=3'"),
    zsh.Alias("cpwd", "pwd | cb"),
    zsh.Alias("npmug", "npm uninstall --global"),
    zsh.Alias("npmig", "npm i -g"),
    zsh.Alias("npmR", "npm run"),
    zsh.Alias("Gbw", "git browse-web"),
    zsh.Alias("cat", "bat --paging=never --plain"),
    zsh.Alias("bwl", "bw login --passwordenv BITWARDENCLI_PASS"),
    zsh.Alias("yazi", "yz"),
    zsh.Alias("vtop", "vtop --theme catppuccin-mocha-lavender"),
    zsh.Alias("cargo-ls", "cargo install --list"),
    zsh.Alias("Gl", "serie"),
    zsh.Alias("tree", "lstr -a -g -G --icons"),
    zsh.Alias("dic", "echo 𓂺"),
  ];

local email = "tazz@tazz.cloud";
local gpg_key = "A7E49DD5";
local gpg_id = "tazz@tazz.cloud";

local Profile(useremail) =
  [
    zsh.Export("USEREMAIL", useremail),
  ];

local Gpg(id, key, tty = "$(tty)") =
  [
    zsh.Export("GPG_ID", id),
    zsh.Export("GPG_KEY", key),
    zsh.Export("GPG_TTY", tty), 
  ];

local LoadProfileSecrets =
  [
    "local ZPROFILE_SECRETS_FILE=\"${ZPROFILE_SECRETS_FILE:-$HOME/.zprofile_secrets.gpg}\"",
    "[[ -f \"$ZPROFILE_SECRETS_FILE\" ]] && source <(gpg --quiet --yes -d \"$ZPROFILE_SECRETS_FILE\")",
  ];

{
  ["zshenv"]:
    zsh.manifest(
      env.Core() + 
      env.Hist() +
      env.Completions() +
      env.AutoSuggest() +
      env.Highlighters() +
      env.Homebrew() + 
      env.Aria2() + 
      env.Navi() +
      env.ZellijSessionizer() +
      [
        zsh.ExportPathPrepend("/usr/local/bin"),
        zsh.ExportFpathPrepend([
          "$ZSH_HOME/functions",
          "$ZSH_HOME/completions",
        ], true),
      ]
    ),
  ["zaliases"]:
    zsh.manifest(
      MiscAliases +
      GpgAliases +
      EditorAliases +
      SuffixAliases +
      GlobalAliases +
      Hashes
    ),
  ["zprofile"]:
    zsh.manifest(
      Profile(email) +
      Gpg(gpg_id, gpg_key) +
      LoadProfileSecrets
    )
}
