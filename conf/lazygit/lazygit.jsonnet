local flexoki = import 'lib/flexoki.libsonnet';
local lazygit = import 'lib/lazygit.libsonnet';

local OS(edit_preset, terminal = true) =
  {
    terminal: terminal,
    editPreset: edit_preset,
  };

local Theme(p) =
  {
    activeBorderColor: [
      p.pu,
    ],
    selectedLineBgColor: [
      p.pu,
    ],
    unstagedChangesColor: [
      p.ye,
    ],
  };

local Gui(theme, show_bottom_line = false, border = 'rounded', nerd_fonts_version = '3') =
  {
    showBottomLine: show_bottom_line,
    theme: theme,
    border: border,
    nerdFontsVersion: nerd_fonts_version,
  };

local Command(key, command, context, output, desc) = 
  {
    key: key,
    command: command,
    context: context,
    output: output,
    description: desc,
  };

local TerminalCommand(key, command, context, desc) =
  Command(key, command, context, 'terminal', desc);

local Git(paging, override_gpg = true) = 
  {
    overrideGpg: override_gpg,
    paging: (if std.isArray(paging) then paging else [ paging ]),
  };

local GitPaging(pager, color_arg = 'always') =
  {
    colorArg: color_arg,
    pager: pager,
  };

local DeltaPaging() = GitPaging('delta --dark --paging=never');

{
  ["config.yaml"]:
    lazygit.Config({
      git: Git(DeltaPaging()),
      os: OS('nvim'),
      gui: Gui(Theme(flexoki.Dark)),
      customCommands: [
        TerminalCommand('C', 'koji', 'files', 'Run koji'),
      ],
    })
}
