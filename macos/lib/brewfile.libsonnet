local util = import 'lib/util.libsonnet';

{
  local Section(name, config, newline_before = false, newline_after = false) =
    util.WrapInOptionalNewlines(
      util.Comment(name) +
      config
    ,newline_before, newline_after),
  local Cask(config, newline_before = false, newline_after = false) =
    Section("Casks", [
      "cask " + util.Quote(cask)
      for cask in config
    ], newline_before, newline_after),
  local Go(config, newline_before = false, newline_after = false) =
    Section("Go", [
      "go " + util.Quote(mod)
      for mod in config
    ], newline_before, newline_after),
  local Cargo(config, newline_before = false, newline_after = false) =
    Section("Cargo", [
      "cargo " + util.Quote(cargo)
      for cargo in config
    ], newline_before, newline_after),
  manifest(config):
    std.lines(
      util.WarningHeaderComment([], '#', false, true) +
      (if "cask" in config then Cask(config["cask"], false, true) else []) +
      (if "go" in config then Go(config["go"], false, true) else []) +
      (if "cargo" in config then Cargo(config["cargo"], false, true) else [])),
}
