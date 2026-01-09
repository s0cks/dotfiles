local zsh = import 'lib/zsh.libsonnet';
{
  LightStyle:
    [
      zsh.Exports({
        TERM_THEME: "light",
        FZF_DEFAULT_OPTS: std.join(" ", [
          "--color=fg:#B7B5AC,bg:#FFFCF0,hl:#100F0F",
          "--color=fg+:#B7B5AC,bg+:#F2F0E5,hl+:#100F0F",
          "--color=border:#AF3029,header:#100F0F,gutter:#FFFCF0",
          "--color=spinner:#3AA99F,info:#3AA99F,separator:#F2F0E5",
          "--color=pointer:#D0A215,marker:#D14D41,prompt:#D0A215",
        ]),
      }),
      "fast-theme -q XDG:flexoki-light",
    ],
  DarkStyle:
    [
      zsh.Exports({
        TERM_THEME: "dark",
        FZF_DEFAULT_OPTS: std.join(" ", [
          "--color=fg:#d0d0d0,fg+:#CECDC3,bg:#100F0F,bg+:#1C1B1A",
          "--color=hl:#8B7EC8,hl+:#5E409D,info:#CECDC3,marker:#879A39",
          "--color=prompt:#5E409D,spinner:#CE5D97,pointer:#5E409D,header:#575653",
          "--color=gutter:#100F0F,border:#282726,preview-bg:#1C1B1A,preview-label:#282726",
          "--color=label:#282726,query:#d9d9d9,disabled:#575653",
          "--preview-window='border-rounded' --prompt='󰄾' --marker='󰅂' --pointer='󰫢'",
          "--separator='─' --scrollbar='│'",
        ]),
      }),
      "fast-theme -q XDG:flexoki-dark",
    ],
}
