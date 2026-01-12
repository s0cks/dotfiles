{
  local STARSHIP = "starship",
  local MISE = "mise",
  local commands = import 'commands.json',
  local has(name) = std.member(commands, name),
  hasStarship: has(STARSHIP),
  hasMise: has(MISE),
}
