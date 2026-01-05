local zsh = import 'lib/zsh.libsonnet';
zsh.Comment("eza", true) +
[
  "local eza_params=('--git' '--icons' '--group' '--group-directories-first' '--time-style=long-iso' '--color-scale=all' '--color')",
  "[[ -v _EZA_PARAMS ]] && eza_params+=($_EZA_PARAMS)",
] +
[
  zsh.Alias("ls", "eza --group-directories-first ${(j: :)eza_params} $@"),
  zsh.Alias("l", "eza --git-ignore --group-directories-first ${(j: :)eza_params}"),
  zsh.Alias("ll", "eza --all --header --long --group-directories-first ${EZA_PARAMS}"),
  zsh.Alias("llm", "eza --all --header --long --sort=modified --group-directories-first ${eza_params}"),
  zsh.Alias("la", "eza -lbhHigUmuSa"),
  zsh.Alias("lx", "eza -lbhHigUmuSa@"),
  zsh.Alias("lt", "eza --tree $eza_params"),
]
