local zsh = import 'lib/zsh.libsonnet';
local env = import 'lib/env.libsonnet';

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
    )
}
