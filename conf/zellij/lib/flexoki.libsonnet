local theme = import 'lib/theme.libsonnet';
local dark = import 'lib/flexoki-dark.json';
{
  FlexokiDarkTheme(indent = 0): theme.Theme('flexoki-dark', [
    // text
    theme.ComponentWithNoEmphasis('text_unselected', dark.tx.rgb, dark.bg.rgb,  indent + 1),
    theme.ComponentWithNoEmphasis('text_selected', dark.tx.rgb, dark.pu.rgb,  indent + 1),
    // ribbon
    theme.ComponentWithNoEmphasis('ribbon_selected', dark.tx.rgb, dark.pu.rgb,  indent + 1),
    theme.ComponentWithNoEmphasis('ribbon_unselected', dark.tx.rgb, dark.bg.rgb,  indent + 1),
    // table
    theme.ComponentWithNoEmphasis('table_title', dark.re.rgb, dark.gr.rgb,  indent + 1),
    theme.ComponentWithNoEmphasis('table_cell_selected', dark.tx.rgb, dark.bg.rgb,  indent + 1),
    theme.ComponentWithNoEmphasis('table_cell_unselected', dark.tx.rgb, dark.bg.rgb,  indent + 1),
    // list
    theme.ComponentWithNoEmphasis('list_selected', dark.tx.rgb, dark.bg.rgb,  indent + 1),
    theme.ComponentWithNoEmphasis('list_unselected', dark.tx.rgb, dark.bg.rgb,  indent + 1),
    // frame
    theme.ComponentWithNoEmphasis('frame_selected', dark.pu.rgb, dark.bg.rgb,  indent + 1),
    theme.ComponentWithNoEmphasis('frame_unselected', dark.tx3.rgb, dark.bg.rgb,  indent + 1),
    theme.ComponentWithNoEmphasis('frame_highlight', dark.ye.rgb, dark.bg.rgb,  indent + 1),
    // exit codes
    theme.ComponentWithNoEmphasis('exit_code_success', dark.gr.rgb, dark.bg.rgb,  indent + 1),
    theme.ComponentWithNoEmphasis('exit_code_error', dark.re.rgb, dark.bg.rgb, indent + 1),
    theme.MultiplayerUserColors([
      dark.re.rgb,
      dark.or.rgb,
      dark.ye.rgb,
      dark.gr.rgb,
      dark.cy.rgb,
      dark.bl.rgb,
      dark.pu.rgb,
      dark.ma.rgb,
    ], indent + 1),
  ], indent),
}
