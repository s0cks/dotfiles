local zsh = import 'lib/zsh.libsonnet';

{
  Core():
    [
      zsh.Export("USER_DATA_HOME", "/usr/local/share"),
      zsh.Export("ZSH_HOME", "$USER_DATA_HOME/zsh"),
      zsh.Export("TEMP", "/tmp"),
      zsh.Export("BROWSER", "open"),
      zsh.Export("EDITOR", "nvim"),
      zsh.Export("PAGER", "less"),
      zsh.Export("MANPAGER", "sh -c 'col -bx | bat -l man -p'"),
      zsh.Export("MANROFFOPT", "-c"),
      zsh.Export("SPROMPT", ""),
      zsh.Export("SPROMPT", "zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? "),
      zsh.Export("WORDCHARS", "${WORDCHARS//[\\/]/}"),
      zsh.Export("AUTOENV_ASSUME_YES", "YES"),
      zsh.Export("PYTHONIOENCODING", "UTF-8"),
      zsh.Export("CACHEDIR", "$ZSH_HOME/cache"),
      zsh.Export("XDG_CONFIG_HOME", "$HOME/.config"),
      zsh.Export("XDG_DATA_HOME", "$HOME/.local/share"),
      zsh.Export("USER_CONFIG_DIR", "$XDG_CONFIG_HOME"),
      zsh.Export("HS_CONFIG_DIR", "$XDG_CONFIG_DIR/hammerspoon"),
      zsh.Export("ORGANIZE_CONFIG", "$XDG_CONFIG_DIR/organize/organize.yml"),
      zsh.Export("VCPKG_ROOT", "$USER_DATA_HOME/vcpkg"),
      zsh.Export("RIPGREP_CONFIG_PATH", "$XDG_CONFIG_HOME/ripgrep/config"),
      zsh.Export("DOTBOT_HOME", "$USER_DATA_HOME/dotbot"),
      zsh.Export("GHQ_ROOT", "$HOME/Projects"),
      zsh.Export("EZA_CONFIG_DIR", "$XDG_CONFIG_HOME/eza"),
    ],
  Hist(savehist = 10000,
       histsize = 32768,
       histfile = "$ZSH_HOME/zsh/history",
       histcontrol="ignoreboth",
       histfilesize="$HISTSIZE"):
    [
      zsh.Export("HISTFILE", histfile),
      zsh.Export("SAVEHIST", savehist),
      zsh.Export("HISTSIZE", histsize),
      zsh.Export("HISTFILESIZE", histfilesize),
      zsh.Export("HISTCONTROL", histcontrol),
    ],
  Completions(completions_dir="$ZSH_HOME/completions"):
    [
      zsh.Export("ZSH_COMPLETIONS_DIR", completions_dir),
    ],
  AutoSuggest(strategy = [ "history", "completion" ],
              buffer_max_size=20,
              manual_rebind = 1,
              use_async = 1):
    [
      zsh.Export("ZSH_AUTOSUGGEST_MANUAL_REBIND", manual_rebind),
      zsh.Export("ZSH_AUTOSUGGEST_USE_ASYNC", use_async),
      zsh.Export("ZSH_AUTOSUGGEST_BUFFER_MAN_SIZE", buffer_max_size),
      zsh.Export("ZSH_AUTOSUGGEST_STRATEGY", strategy),
    ],
  Highlighters(highlighters = [ "main", "brackets", "pattern", "cursor" ]):
    [
      zsh.Export("ZSH_HIGHLIGHT_HIGHLIGHTERS", highlighters)
    ],
  Homebrew(color = true, no_env_hints = true):
    [
      zsh.Export("HOMEBREW_COLOR", zsh.Quote(color)),
      zsh.Export("HOMEBREW_NO_ENV_HINTS", zsh.Quote(no_env_hints)),
    ],
  Aria2(home = "$USER_DATA_HOME/aria2"):
    [
      zsh.Export("ARIA2_HOME", "$USER_DATA_HOME/aria2"),
      zsh.Export("ARIA2_USER_AGENT", "$USER_AGENT"),
    ],
  Navi(config = "$XDG_CONFIG_HOME/navi/config.yaml",
       path = [ "$XDG_DATA_HOME/navi/cheats", "/usr/local/share/cheats" ]):
    [
      zsh.Export("NAVI_CONFIG", config),
      zsh.Export("NAVI_PATH", std.join(':', path)),
    ],
  ZellijSessionizer(search_paths = [ "$HOME/Projects" ]):
    [
      zsh.Export("ZELLIJ_SESSIONIZER_SEARCH_PATHS", std.join(':', search_paths)),
    ],
}
