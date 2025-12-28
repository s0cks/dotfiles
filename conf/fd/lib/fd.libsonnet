{
  Comment(lines):
    [
      "# %(line)s" % { line: line }
      for line in (if std.isArray(lines) then lines else [ lines ])
    ],
  Section(title, entries):
    [
      $.Comment(title),
      entries,
    ],
  VersionControl():
    $.Section('Version Control', [
      '.git',
      '.svn',
      '.hg',
      '.cvs',
    ]),
  Nodejs():
    $.Section('Node.js', [
      'node_modules/',
      '.npm'
    ]),
  Python():
    $.Section('Python', [
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
    ]),
  Java():
    $.Section('Java', [
      '*.class',
      '*.jar',
      '*.war',
      '*.ear',
      'target/',
      'out/',
    ]),
  Rust():
    $.Section('Rust', [
      'target/',
    ]),
  Go():
    $.Section('Go', [
      'vendor/',
      '*.exe',
      '*.out',
    ]),
  Ruby():
    $.Section('Ruby', [
      '.bundle',
      'vendor/bundle',
    ]),
  PHP():
    $.Section('PHP Composer', [
      'vendor/',
    ]),
  CC():
    $.Section('C/C++', [
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
    ]),
  Logs():
    $.Section('Logs', [
      '*.log',
      'logs/',
    ]),
  MacOS():
    $.Section('MacOS', [
      '.DS_Store',
    ]),
  Editors():
    $.Section('Editors', [
      '.vscode',
      '.idea',
      '*.swp',
      '*.swo',
      '*~',
    ]),
  Testing():
    $.Section('Testing & Coverage', [
      '.coverage',
      'coverage/',
      '.nyc_output',
    ]),
  local EMPTY = '',
  manifest(sections):
    std.lines(std.flattenDeepArray([
      [ section, EMPTY ],
      for section in (if std.isArray(sections) then sections else [ sections ])
    ])),
}
