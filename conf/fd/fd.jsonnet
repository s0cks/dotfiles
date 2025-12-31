local fd = import 'lib/fd.libsonnet';
local util = import 'lib/util.libsonnet';

local Section(title, entries) =
  [
    util.Comment(title),
    entries,
  ];

local VersionControl() =
  Section('Version Control', [
    '.git',
    '.svn',
    '.hg',
    '.cvs',
  ]);

local Nodejs() =
  Section('Node.js', [
    'node_modules/',
    '.npm'
  ]);

local Python() =
  Section('Python', [
    '__pycache__',
    '*.pyc',
    '*.pyo',
    '*.pyd',
    '.mypy_cache',
    '.pytest',
    'migrations',
    '.venv',
    '.myenv',
    'env/',
    'venv/',
    '.idea/',
  ]);

local Java() =
  Section('Java', [
    '*.class',
    '*.jar',
    '*.war',
    '*.ear',
    'target/',
    'out/',
  ]);

local Rust() =
  Section('Rust', [
    'target/',
  ]);

local Go() =
  Section('Go', [
    'vendor/',
    '*.exe',
    '*.out',
  ]);

local Ruby() =
  Section('Ruby', [
    '.bundle',
    'vendor/bundle',
  ]);

local PHP() =
  Section('PHP Composer', [
    'vendor/',
  ]);

local CC() =
  Section('C/C++', [
    'build/',
    'CMakeFiles/',
    '*.o',
    '*.a',
    '*.obj',
    '*.so',
    '*.dylib',
    '*.dll',
    '*.exe',
    '*.out',
  ]);

local Logs() =
  Section('Logs', [
    '*.log',
    'logs/',
  ]);

local MacOS() =
  Section('MacOS', [
    '.DS_Store',
  ]);

local Editors() =
  Section('Editors', [
    '.vscode',
    '.idea',
    '*.swp',
    '*.swo',
    '*~',
  ]);

local Testing() =
  Section('Testing & Coverage', [
    '.coverage',
    'coverage/',
    '.nyc_output',
  ]);

local EMPTY = '';
local Ignorefile(sections) =
  std.lines(util.Comment([
    "*** Do not edit ***",
    "This file is auto-generated using Jsonnet",
  ])) +
  std.lines([ EMPTY ]) +
  std.lines(std.flattenDeepArray([
    [ section, EMPTY ],
    for section in (if std.isArray(sections) then sections else [ sections ])
  ]));

{
  ["ignore"]:
    Ignorefile([
      VersionControl(),
      Nodejs(),
      Python(),
      Java(),
      Rust(),
      Go(),
      Ruby(),
      PHP(),
      CC(),
      Logs(),
      MacOS(),
      Editors(),
      Testing(),
    ]),
}
