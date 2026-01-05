local zstyle = import 'lib/zstyle.libsonnet';


local Completions =
  [
    zstyle.StyleMap(":completion:*", {
      "file-list": "all",
      "use-cache": "on",
      "cache-path": '"$XDG_CACHE_HOME/zsh/.zcompcache"',
      // set list-colors to enable filename colorizing
      "list-colors": "${(s.:.)LS_COLORS}",
      // force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
      "menu": "no",
    }),
    // disable sort when completing `git checkout`
    zstyle.Style(':completion:*:git-checkout:*', "sort", "false"),
    // set descriptions format to enable group support
    zstyle.Style(":completion:*:descriptions", "format", "'[%d]'"),
  ];

local FzfTab =
  [
    // preview directory's content with eza when completing cd
    // NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
    zstyle.Style(':fzf-tab:complete:cd:*', "fzf-preview", 'eza -1 --color=always --no-permissions --no-time --no-filesize --no-user $realpath'),
    zstyle.Style(':fzf-tab:complete:ls:*', "fzf-preview", 'eza -1 --color=always --no-permissions --no-time --no-filesize --no-user $realpath'),
    zstyle.StyleMap(":fzf-tab:*", {
      // custom fzf flags
      // NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
      "fzf-flags": "--color=fg:1,fg+:2 --bind=tab:accept",
      // To make fzf-tab follow FZF_DEFAULT_OPTS.
      // NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
      "use-fzf-default-opts": "yes",
      // switch group using `<` and `>`
      "switch-group": "'<': '>'",
    })
  ];


[
  // ':zim:zmodule': "use 'degit'",
  zstyle.Style(":zim:input", "double-dot-expand", "yes"),
] +
Completions +
FzfTab
