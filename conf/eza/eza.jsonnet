local eza = import 'lib/eza.libsonnet';
local flexoki = import "lib/flexoki.libsonnet";
local FlexokiDark = flexoki.Dark;

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

local filekinds(p) = {
  normal: ForegroundDefault,
  directory: Foreground(p.pu) + Bold,
  symlink: Foreground(p.cy),
  pipe: Foreground(p.ye),
  block_device: Foreground(p.ye) + Bold,
  char_device: Foreground(p.ye) + Bold,
  socket: Foreground(p.re) + Bold,
  special: Foreground(p.ye),
  executable: Foreground(p.ma) + Bold,
  mount_point: Foreground(p.bl) + Bold,
};

local perms(p) = {
  user_read: Foreground(p.ye) + Bold,
  user_write: Foreground(p.re) + Bold,
  user_executable_file: Foreground(p.gr) + Bold,
  user_executable_other: Foreground(p.gr) + Bold,
  group_read: Foreground(p.ye),
  group_write: Foreground(p.re),
  group_execute: Foreground(p.gr),
  other_read: Foreground(p.ye),
  other_write: Foreground(p.re),
  other_execute: Foreground(p.gr),
  special_user_file: Foreground(p.pu),
  special_other: Foreground(p.pu),
  attribute: ForegroundDefault,
};

local size(p) = {
  major: Foreground(p.tx) + Bold,
  minor: Foreground(p.tx),
  number_byte: Foreground(p.tx) + Bold,
  number_kilo: Foreground(p.tx) + Bold,
  number_mega: Foreground(p.tx) + Bold,
  number_giga: Foreground(p.tx) + Bold,
  number_huge: Foreground(p.tx) + Bold,
  unit_byte: Foreground(p.tx),
  unit_kilo: Foreground(p.tx),
  unit_mega: Foreground(p.tx),
  unit_giga: Foreground(p.tx),
  unit_huge: Foreground(p.tx),
};

local users(p) = {
  user_you: Foreground(p.ye) + Bold,
  user_root: ForegroundDefault,
  user_other: ForegroundDefault,
  group_yours: Foreground(p.ye) + Bold,
  group_other: ForegroundDefault,
  group_root: ForegroundDefault,
};

local links(p) = {
  normal: Foreground(p.re) + Bold,
  multi_link_file: Foreground(p.re) + Background(p.ye),
};

local git(p) = {
  new: Foreground(p.gr),
  modified: Foreground(p.bl),
  deleted: Foreground(p.re),
  renamed: Foreground(p.ye),
  typechange: Foreground(p.pu),
  ignored: ForegroundDefault + Dimmed,
  conflicted: Foreground(p.re),
};

local git_repo(p) = {
  branch_main: Foreground(p.gr),
  branch_other: Foreground(p.ye),
  git_clean: Foreground(p.gr),
  git_dirty: Foreground(p.ye),
};

local security_context(p) = {
  colon: ForegroundDefault + Dimmed,
  user: Foreground(p.bl),
  role: Foreground(p.gr),
  typ: Foreground(p.ye),
  range: Foreground(p.cy),
};

local file_type(p) = {
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

{
  ["flexoki-dark.yml"]: eza.Theme({
      punctuation: Foreground(FlexokiDark.tx2) + Bold,
      date: Foreground(FlexokiDark.cy),
      inode: Foreground(FlexokiDark.pu),
      blocks: Foreground(FlexokiDark.cy),
      header: ForegroundDefault + Underline,
      octal: Foreground(FlexokiDark.pu),
      flags: ForegroundDefault,
      symlink_path: Foreground(FlexokiDark.cy),
      control_char: Foreground(FlexokiDark.re),
      broken_symlink: Foreground(FlexokiDark.re),
      broke_path_overlay: ForegroundDefault + Underline,

      filekinds: filekinds(FlexokiDark),
      perms: perms(FlexokiDark),
      size: size(FlexokiDark),
      file_type: file_type(FlexokiDark),
      users: users(FlexokiDark),
      links: links(FlexokiDark),
      git: git(FlexokiDark),
      git_repo: git_repo(FlexokiDark),
      security_context: security_context(FlexokiDark),
    }),
}
