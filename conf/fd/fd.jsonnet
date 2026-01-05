local fd = import 'lib/fd.libsonnet';
local util = import 'lib/util.libsonnet';

local VersionControl() =
  fd.Section('Version Control', [
    '.git',
    '.svn',
    '.hg',
    '.cvs',
  ], false, true);

local Nodejs() =
  fd.Section('Node.js', [
    'node_modules/',
    '.npm'
  ], false, true);

local Python() =
  fd.Section('Python', [
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
  ], false, true);

local Java() =
  fd.Section('Java', [
    '*.class',
    '*.jar',
    '*.war',
    '*.ear',
    'target/',
    'out/',
  ], false, true);

local Rust() =
  fd.Section('Rust', [
    'target/',
  ], false, true);

local Go() =
  fd.Section('Go', [
    'vendor/',
    '*.exe',
    '*.out',
  ], false, true);

local Ruby() =
  fd.Section('Ruby', [
    '.bundle',
    'vendor/bundle',
  ], false, true);

local PHP() =
  fd.Section('PHP & Composer', [
    'vendor/',
  ], false, true);

local CC() =
  fd.Section('C/C++', [
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
  ], false, true);

local Logs() =
  fd.Section('Logs', [
    '*.log',
    'logs/',
  ], false, true);

local MacOS() =
  fd.Section('MacOS', [
    '.DS_Store',
  ], false, true);

local Editors() =
  fd.Section('Editors', [
    '.vscode',
    '.idea',
    '*.swp',
    '*.swo',
    '*~',
  ], false, true);

local Testing() =
  fd.Section('Testing & Coverage', [
    '.coverage',
    'coverage/',
    '.nyc_output',
  ], false, true);

{
  ["ignore"]:
    fd.manifest(
      VersionControl() +
      Nodejs() +
      Python() +
      Java() +
      Rust() +
      Go() +
      Ruby() +
      PHP() +
      CC() +
      Logs() +
      MacOS() +
      Editors() +
      Testing()
    ),
}
