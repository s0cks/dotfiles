local defaults = import 'lib/defaults.libsonnet';

std.lines(
  defaults.Header(false, true) +
  [
    "# references:",
    "# - https://github.com/driesvints/dotfiles/blob/main/.macos",
    "osascript -e 'tell application \"System Preferences\" to quit'",
    "sudo -v",
    "while true; do",
    "  sudo -n true",
    "  sleep 60",
    "  kill -0 \"$$\" || exit",
    "done 2>/dev/null &",
    "# disable boot sounds",
    'sudo nvram SystemAudioVolume=""',
  ]
)+
defaults.DefaultsFile(
  (import 'lib/defaults/finder.libsonnet') +
  (import 'lib/defaults/ns_global_domain.libsonnet') +
  (import 'lib/defaults/screencapture.libsonnet') +
  (import 'lib/defaults/crash_reporter.libsonnet')
)
