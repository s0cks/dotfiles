local util = import 'lib/util.libsonnet';

local Style(name, color, width) =
  {
    [name]: {
      color: color,
      width_percentage: width,
    },
  };
local TagStyle(color, width) = Style("tag", color, width);
local CommentStyle(color, width) = Style("comment", color, width);
local SnippetStyle(color, width) = Style("snippet", color, width);

{
  "config.yaml": 
    std.lines(util.WarningHeaderComment([], "#", false, true)) +
    std.manifestYamlDoc({
      style:
        TagStyle("dark_magenta", 10) +
        CommentStyle("grey", 50) +
        SnippetStyle("dark_grey", 40),
      }, true, false),
}
