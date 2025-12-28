{
  Search(filters):
    {
      filters: if std.isArray(filters) then filters else [ filters ],
    },
  Theme(name = "autumn", debug = false):
    {
      // Color theme to use for rendering in the terminal.
      // There are some built-in themes, including the base theme ("default"),
      // "autumn" and "marine". You can add your own themes to the "./themes" subdirectory of your
      // Atuin config (or ATUIN_THEME_DIR, if provided) as TOML files whose keys should be one or
      // more of AlertInfo, AlertWarn, AlertError, Annotation, Base, Guidance, Important, and
      // the string values as lowercase entries from this list:
      //    https://ogeon.github.io/docs/palette/master/palette/named/index.html
      // If you provide a custom theme file, it should be  called "NAME.toml" and the theme below
      // should be the stem, i.e. `theme = "NAME"` for your chosen NAME.
      name: name,
      // Whether the theme manager should output normal or extra information to help fix themes.
      // Boolean, true or false. If unset, left up to the theme manager.
      debug: debug,
    },
  Sync(records = true):
    {
      records: records,
    },
  Preview(strategy):
    {
      strategy: strategy,
    },
  StaticPreview: $.Preview('static'),
  FixedPreview: $.Preview('fixed'),
  AutoPreview: $.Preview('auto'),
  Keys(scroll_exits = true, exit_past_line_start = true, accept_past_line_end = true):
    {
      // Defaults to true. If disabled, using the up/down key won't exit the TUI when scrolled past the first/last entry.
      scroll_exits: scroll_exits,
      // Defaults to true. The left arrow key will exit the TUI when scrolling before the first character
      exit_past_line_start: exit_past_line_start,
      // Defaults to true. The right arrow key performs the same functionality as Tab and copies the selected line to the command line to be modified.
      accept_past_line_end: accept_past_line_end,
    },
  Stats(ignored_subcommands, ignored_prefixes, ignored_commands):
    {
      common_subcommands: ignored_subcommands,
      common_prefix: ignored_prefixes,
      ignored_commands: ignored_commands,
    },
  local DEFAULT_DAEMON_SYNC_FREQ = 300,
  local DEFAULT_DAEMON_SOCKET_PATH = "~/.local/share/atuin/atuin.sock",
  local DEFAULT_DAEMON_PORT = 8889,
  Daemon(enabled,
         sync_freq = self.DEFAULT_DAEMON_SYNC_FREQ,
         socket_path = DEFAULT_DAEMON_SOCKET_PATH,
         port = self.DEFAULT_DAEMON_PORT):
    {
      enabled: enabled,
      sync_frequency: sync_freq,
      socket_path: socket_path,
      tcp_port: port,
    },
  LinuxDaemon(enabled = true,
              sync_freq = self.DEFAULT_DAEMON_SYNC_FREQ,
              socket_path = self.DEFAULT_DAEMON_SOCKET_PATH,
              port = self.DEFAULT_DAEMON_PORT,
              systemd_socket = false):
    self.Daemon(enabled, sync_freq, socket_path, port, systemd_socket) + {
      systemd_socket: systemd_socket,
    },
  DisabledDaemon: { enabled: false },
}
