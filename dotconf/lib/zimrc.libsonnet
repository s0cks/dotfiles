local zimfw = import 'lib/zimfw.libsonnet';
local commands = import 'commands.json';

zimfw.Modules([
  "environment",
  "git",
  "input",
  "termtitle",
  "utility",
  "archive",
  // "decayofmind/zsh-fast-alias-tips",
  "fzf",
  "git-info",
  "hlissner/zsh-autopair",
  "toku-sa-n/zsh-dot-up",
  "antonjs/zsh-gpt",
  "Aloxaf/fzf-tab",
  "olets/zsh-abbr",
  // "s0cks/zsh-autoenv",
]) +
[
  // zimfw.ModuleIfCommands("s0cks/zsh-yeoman", "yo"),
  // zimfw.ModuleIfCommands("s0cks/zsh-zoxide", "zoxide"),
  zimfw.ModuleIfCommands("marcelohmdias/zsh-atuin", "atuin"),
  // zimfw.ModuleIfCommands("s0cks/zsh-mise", "mise"),
  // zimfw.ModuleIfCommands("s0cks/zsh-cargo", "cargo"),
  // zimfw.ModuleIfCommands("s0cks/zsh-zellij-sessionizer", "zellij"),
  zimfw.Module("zsh-users/zsh-completions", null, "src"),
] +
zimfw.Modules([
  "completion",
  "zdharma-continuum/fast-syntax-highlighting",
  "zsh-users/zsh-history-substring-search",
  "zsh-users/zsh-autosuggestions",
  "olets/zsh-autosuggestions-abbreviations-strategy",
])
// [
//   zimfw.ModuleIfCommands("Game4Move78/zsh-bitwarden", [ "bw", "rbw" ], " || "),
//   zimfw.ModuleIfCommands("s0cks/zsh-vcpkg", "vcpkg"),
// ]
