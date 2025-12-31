local flexoki = import 'lib/flexoki.libsonnet';
local serie = import 'lib/serie.libsonnet';
local util = import 'lib/util.libsonnet';

local CoreOption(protocol = 'kitty',
                 order = 'chrono',
                 graph_width = 'auto',
                 initial_selection = 'latest') =
  {
    # The protocol type for rendering images of commit graphs.
    # The value specified in the command line argument takes precedence.
    # type: enum (possible values: "auto", "iterm", "kitty")
    protocol: protocol,
    # The commit ordering algorithm.
    # The value specified in the command line argument takes precedence.
    # type: enum (possible values: "chrono", "topo")
    order: order,
    # The character width that a graph image unit cell occupies.
    # The value specified in the command line argument takes precedence.
    # type: enum (possible values: "auto", "double", "single")
    graph_width: graph_width,
    # The initial selection of commit when starting the application.
    # The value specified in the command line argument takes precedence.
    # type: enum (possible values: "latest", "head")
    initial_selection: initial_selection,
  };

local CoreSearch(ignore_case = true, fuzzy = true) =
  {
    # Whether to enable ignore case by default.
    # type: boolean
    ignore_case: ignore_case,
    # Whether to enable fuzzy matching by default.
    # type: boolean
    fuzzy: fuzzy,
  };

local CoreUserCommand(tab_width = 2) =
  {
    # The command definition for generating the content displayed in the user command view.
    # Multiple commands can be specified in the format commands_{n}.
    # For details about user command, see the separate User command section.
    # type: object
    commands_1: {
      name: "git diff",
      commands: [
        "git",
        "--no-pager",
        "diff",
        "--color=always",
        "{{first_parent_hash}}",
        "{{target_hash}}",
      ],
    },
    # The number of spaces to replace tabs in the user command output.
    # type: u16
    tab_width: tab_width,
  };

local UICommon(cursor_type = "Native") =
  {
    # The type of a cursor to display in the input.
    # If `cursor_type = "Native"` is set, the terminal native cursor is used.
    # If `cursor_type = { "Virtual" = "|" }` is set, a virtual cursor with the specified string will be used.
    # type: enum
    cursor_type: "Native"
  };

local UIList() =
  {
    # The minimum width of a subject in the commit list.
    # type: u16
    subject_min_width: 20,
    # The date format of a author date in the commit list.
    # The format must be specified in strftime format.
    # https://docs.rs/chrono/latest/chrono/format/strftime/index.html
    # type: string
    date_format: "%m/%d/%Y",
    # The width of a author date in the commit list.
    # type: u16
    date_width: 10,
    # Whether to show a author date in the commit list in local timezone.
    # type: boolean
    date_local: true,
    # The width of a author name in the commit list.
    # type: u16
    name_width: 10,
  };

local UIDetail() =
  {
    # The height of a commit detail area.
    # type: u16
    height: 20,
    # The date format of a author/committer date in the commit detail.
    # The format must be specified in strftime format.
    # https://docs.rs/chrono/latest/chrono/format/strftime/index.html
    # type: string
    date_format: "%m/%d/%Y %H:%M %z",
    # Whether to show a author/committer date in the commit list in local timezone.
    # type: boolean
    date_local: true,
  };

local UIUserCommand() =
  {
    # The height of a user command area.
    # type: u16
    height: 20,
  };

local UIRefs() =
  {
    # The width of a refs list area.
    # type: u16
    width: 26,
  };

local GraphColor(p) =
  {
    # Colors should be specified in the format #RRGGBB or #RRGGBBAA.
    # Array of colors used for the commit graph.
    # type: array of strings
    branches: p.rainbow(),
    # Color of the edge surrounding the commit circles in the graph.
    # type: string
    edge: p.pu,
    # Background color of the commit graph.
    # type: string
    background: p.bg2,
  };

local Color(p) =
  {
    # The colors of each element of the application.
    # Note: Graph colors are specified with [graph.color].
    #
    # Colors should be specified in one of the following formats:
    # - ANSI color name
    #   - "red", "bright-blue", "light-red", "reset", ...
    # - 8-bit color (256-color) index values
    #   - "34","128","255",...
    # - 24-bit true color hex codes
    #   - "#abcdef",...
    # type: string
    fg: p.tx,
    bg: p.bg2,

    detail_email_fg: p.pu,
    detail_ref_branch_fg: p.ye,
    detail_ref_remote_branch_fg: p.ye,
    detail_ref_tag_fg: p.bl,
    detail_file_change_add_fg: p.gr,
    detail_file_change_modify_fg: p.cy,
    detail_file_change_delete_fg: p.re,
    detail_file_change_move_fg: p.ma,

    help_block_title_fg: "#879A39",
    help_key_fg: "#D0A215",
    virtual_cursor_fg: "reset",
    divider_fg: p.bg,
  };

local RefSelected(p) =
  {
    ref_selected_fg: p.tx,
    ref_selected_bg: p.ui,
  };

local List(p) =
  {
    list_head_fg: p.pu,
    list_subject_fg: p.tx,
    list_name_fg: p.pu,
    list_hash_fg: p.pu,
    list_date_fg: p.tx,
    list_match_fg: p.tx,
    list_match_bg: p.bg,
  };

local ListRef(p) =
  {
    list_ref_paren_fg: "#D0A215",
    list_ref_branch_fg: p.ye,
    list_ref_remote_branch_fg: p.ye,
    list_ref_tag_fg: p.cy,
    list_ref_stash_fg: p.ma,
  };

local ListSelected(p) =
  {
    list_selected_fg: p.tx,
    list_selected_bg: p.ui,
  };

local StatusColor(p) =
  {
    status_input_fg: p.tx,
    status_input_transient_fg: p.tx,
    status_info_fg: p.tx,
    status_success_fg: p.tx,
    status_warn_fg: p.ye,
    status_error_fg: p.re,
  };

local Keybind() =
  {
    # See ./assets/default-keybind.toml for a specific example configuration.
    # ...
  };

{
  ["config.toml"]:
    std.lines(util.Comment([
      "*** Do not edit ***",
      "This file was auto-generated by Jsonnet",
    ])) +
    serie.Config({
      "core.option": CoreOption(),
      "core.search": CoreSearch(),
      "core.user_command": CoreUserCommand(),
      "ui.common": UICommon(),
      "ui.list": UIList(),
      "ui.detail": UIDetail(),
      "ui.user_command": UIUserCommand(),
      "ui.refs": UIRefs(),
      "graph.color": GraphColor(flexoki.Dark),
      "color": Color(flexoki.Dark) +
                RefSelected(flexoki.Dark) +
                List(flexoki.Dark) +
                ListRef(flexoki.Dark) +
                ListSelected(flexoki.Dark) +
                StatusColor(flexoki.Dark),
      "keybind": Keybind(),
    }),
}
