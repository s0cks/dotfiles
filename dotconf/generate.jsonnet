local zsh = import 'lib/zsh.libsonnet';
local env = import 'lib/env.libsonnet';
local zimfw = import 'lib/zimfw.libsonnet';

local hashes = import 'lib/hashes.json';

local MiscAliases = import 'lib/aliases/misc.libsonnet';
local GpgAliases = import 'lib/aliases/gpg.libsonnet';
local SuffixAliases = import 'lib/aliases/suffix.libsonnet';
local GlobalAliases = zsh.GlobalAliasMap(import 'lib/aliases/global.json');
local EditorAliases = zsh.Alias(import 'lib/aliases/editor.json', 'editz');

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
  [".zshenv"]:
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
  [".zaliases"]:
    zsh.manifest(
      zsh.Comment("misc aliases", true) +
      MiscAliases +
      zsh.Comment("gpg Aliases", true) +
      GpgAliases +
      zsh.Comment("editor aliases", true) +
      EditorAliases +
      zsh.Comment("suffix aliases", true) +
      SuffixAliases +
      zsh.Comment("global aliases", true) +
      GlobalAliases +
      zsh.Comment("hashes (directory aliases)", true) +
      zsh.Hashes(hashes)
    ),
  [".zprofile"]:
    zsh.manifest(
      Profile(email) +
      Gpg(gpg_id, gpg_key) +
      LoadProfileSecrets
    ),
  [".zimrc"]:
    zsh.manifest(
      zimfw.Modules([
        "environment",
        "git",
        "input",
        "termtitle",
        "utility",
        "archive",
        "decayofmind/zsh-fast-alias-tips",
        "fzf",
        "git-info",
        "hlissner/zsh-autopair",
        "toku-sa-n/zsh-dot-up",
        "antonjs/zsh-gpt",
        "Aloxaf/fzf-tab",
        "olets/zsh-abbr",
        "s0cks/zsh-autoenv",
      ]) +
      [
        zimfw.ModuleIfCommands("s0cks/zsh-starship", "starship"), 
        zimfw.ModuleIfCommands("s0cks/zsh-yeoman", "yo"),
        zimfw.ModuleIfCommands("s0cks/zsh-zoxide", "zoxide"),
        zimfw.ModuleIfCommands("s0cks/zsh-atuin", "atuin"),
        zimfw.ModuleIfCommands("s0cks/zsh-mise", "mise"),
        zimfw.ModuleIfCommands("s0cks/zsh-cargo", "cargo"),
        zimfw.ModuleIfCommands("s0cks/zsh-zellij-sessionizer", "zellij"),
        zimfw.Module("zsh-users/zsh-completions", null, "src"),
      ] +
      zimfw.Modules([
        "completion",
        "zdharma-continuum/fast-syntax-highlighting",
        "zsh-users/zsh-history-substring-search",
        "zsh-users/zsh-autosuggestions",
        "olets/zsh-autosuggestions-abbreviations-strategy",
      ]) +
      [
        zimfw.ModuleIfCommands("Game4Move78/zsh-bitwarden", [ "bw", "rbw" ], " || "),
        zimfw.ModuleIfCommands("s0cks/zsh-vcpkg", "vcpkg"),
      ]),
}
