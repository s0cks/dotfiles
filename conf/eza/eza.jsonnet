local eza = import 'lib/eza.libsonnet';
local flexoki = import "lib/flexoki.libsonnet";

local DEFAULT = "Default";
local Foreground(color) = {
  foreground: color,
};
local ForegroundDefault = Foreground(DEFAULT);
local Background(color) = {
  background: color,
};
local Bold = { is_bold: true };
local Underline = { is_underline: true };
local Dimmed = { is_dimmed: true };

local FileKinds(p) = {
  normal: ForegroundDefault,
  directory: Foreground(p.bl) + Bold,
  symlink: Foreground(p.cy),
  pipe: Foreground(p.ye),
  block_device: Foreground(p.ye) + Bold,
  char_device: Foreground(p.ye) + Bold,
  socket: Foreground(p.re) + Bold,
  special: Foreground(p.ye),
  executable: Foreground(p.gr) + Bold,
  mount_point: Foreground(p.or) + Bold,
};

local Permissions(p) = {
  local Read = Foreground(p.gr),
  local Write = Foreground(p.ye),
  local Exec = Foreground(p.re),
  local Special = Foreground(p.ma),
  attribute: ForegroundDefault,
  // special
  special_user_file: Special,
  special_other: Special,
  // user
  user_read: Read + Bold,
  user_write: Write + Bold,
  user_executable_file: Exec + Bold,
  user_executable_other: Exec + Bold,
  // group
  group_read: Read,
  group_write: Write,
  group_execute: Exec,
  // other
  other_read: Read,
  other_write: Write,
  other_execute: Exec,
};

local FileSize(c) = 
  {
    local Fg = Foreground(c),
    local FgBold = Fg + Bold,
    major: FgBold,
    minor: Fg,
    number_byte: FgBold,
    number_kilo: FgBold,
    number_mega: FgBold,
    number_giga: FgBold,
    number_huge: FgBold,
    unit_byte: Fg,
    unit_kilo: Fg,
    unit_mega: Fg,
    unit_giga: Fg,
    unit_huge: Fg,
  };

local Users(p) = {
  local User = Foreground(p.pu),
  local Others = ForegroundDefault,
  local Root = Foreground(p.ma) + Bold,
  // users
  user_you: User,
  user_root: Root,
  user_other: Others,
  // groups
  group_yours: User,
  group_root: Root,
  group_other: Others,
};

local Links(p) = {
  normal: Foreground(p.re) + Bold,
  multi_link_file: Foreground(p.re) + Background(p.ye),
};

local Git(p) = {
  new: Foreground(p.gr),
  modified: Foreground(p.bl),
  deleted: Foreground(p.re),
  renamed: Foreground(p.ye),
  typechange: Foreground(p.pu),
  ignored: ForegroundDefault + Dimmed,
  conflicted: Foreground(p.re),
};

local GitRepo(p) = {
  branch_main: Foreground(p.gr),
  branch_other: Foreground(p.ye),
  git_clean: Foreground(p.gr),
  git_dirty: Foreground(p.ye),
};

local SecurityContext(p) = {
  colon: ForegroundDefault + Dimmed,
  user: Foreground(p.bl),
  role: Foreground(p.gr),
  typ: Foreground(p.ye),
  range: Foreground(p.cy),
};

local FileType(p) = {
  image: Foreground(p.pu),
  video: Foreground(p.pu) + Bold,
  music: Foreground(p.cy),
  lossless: Foreground(p.cy) + Bold,
  crypto: Foreground(p.gr) + Bold,
  document: Foreground(p.gr),
  compressed: Foreground(p.re),
  temp: Foreground(p.ye),
  compiled: Foreground(p.ma),
  build: Foreground(p.ma) + Bold + Underline,
  source: Foreground(p.gr) + Bold,
};

local Theme(p) =
  eza.Theme({
    punctuation: Foreground(p.tx2) + Bold,
    date: Foreground(p.tx2),
    inode: Foreground(p.pu),
    blocks: Foreground(p.cy),
    header: ForegroundDefault + Underline,
    octal: Foreground(p.pu),
    flags: ForegroundDefault,
    symlink_path: Foreground(p.cy),
    control_char: Foreground(p.re),
    broken_symlink: Foreground(p.re),
    broke_path_overlay: ForegroundDefault + Underline,
    filekinds: FileKinds(p),
    perms: Permissions(p),
    size: FileSize(p.cy),
    file_type: FileType(p),
    users: Users(p),
    links: Links(p),
    git: Git(p),
    git_repo: GitRepo(p),
    security_context: SecurityContext(p),
  });

{
  ["flexoki-dark.yml"]: Theme(flexoki.Dark),
  ["flexoki-light.yml"]: Theme(flexoki.Light),
}
