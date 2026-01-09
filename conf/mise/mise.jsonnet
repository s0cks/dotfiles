local mise = import 'lib/mise.libsonnet';
local XDG_CONFIG_HOME = std.extVar('XDG_CONFIG_HOME');
local MISE_CONFIG_HOME = XDG_CONFIG_HOME + "/mise";

local DefaultPackagesFile(name) =
  {
    default_packages_file: MISE_CONFIG_HOME + "/." + name,
  };

local Settings() =
  {
    settings: {
      idiomatic_version_file_enable_tools: [],
      python:
        {
        } +
        DefaultPackagesFile("default-python-packages"),
      ruby:
        {
        } +
        DefaultPackagesFile("default-gems"),
      experimental: true,
    }
  };

local Env() =
  {
    env: {
      NODE_ENV: "dev",
      BUILD_ENVIRONMENT: "dev",
    }
  };

local Tools() =
  {
    tools: {
      go: [ "latest", "1.25.4"],
      java: [ "latest", "25.0.1" ],
      clojure: "latest",
      lua: [ "latest", "5.4.8", "5.2" ],
      node: [ "latest", "lts" ],
      python: [ "latest", "3.14" ],
      ruby: [ "latest", "3.4.7"],
      ["go-jsonnet"]: [ "latest" ],
      dotnet: [ "latest", "10.0.100" ],
      rust: [ "latest", "1.91.1" ],
      perl: [ "latest", "5.42.0.0" ],
      nasm: [ "latest", "3.01" ],
      cmake: [ "latest", "4.2" ],
      bazel: [ "latest", "8.4.2" ],
      gradle: [ "latest", "9.2.1" ],
      maven: [ "latest", "3.9.11" ],
      ninja: [ "latest", "1.13.2" ],
      pipx: [ "latest", "1.8.0" ],
      tflint: [ "latest", "0.60.0" ],
      vale: [ "latest", "3.13.0" ],
      terraform: [ "latest", "1.14.1" ],
      shfmt: [ "latest", "3.12.0" ],
      yamlfmt: [ "latest", "0.20.0" ],
      marksman: [ "latest", "2025-11-30" ],
      typos: [ "latest", "1.40.0" ],
      ruff: [ "latest", "0.14.9" ],
      cocogitto: [ "latest", "6.5.0" ],
      uv: [ "latest" ],
      ghq: [ "latest" ],
      make: {
        version: "4.4.1",
        os: [ "linux" ],
      },
    },
  };

local PipPkg(name, version) = name + "==" + version;

{
  ["config.toml"]:
    mise.manifest(
      {
        min_version: "2025.7.27"
      } +
      Settings() +
      Env() +
      Tools()),
  [".default-python-packages"]:
    std.lines([
      PipPkg("buku", "5.1"),
      PipPkg("httpie", "3.2.4"),
      PipPkg("lizard", "1.19.0"),
      PipPkg("howdoi", "2.0.20"),
      PipPkg("check-jsonschema", "0.35.0 "),
      PipPkg("pyright", "1.1.407"),
      PipPkg("git-sweep", "0.1.1"),
      PipPkg("gitlint", "0.19.1"),
      PipPkg("organize-tool", "3.3.0"),
      PipPkg("pyaml", "24.7.0"),
      PipPkg("tuir-continued", "1.32.0"),
      PipPkg("virtualenv", "20.31.2"),
      PipPkg("emoji-fzf", "0.10.0"),
    ]),
  [".default-gems"]:
    std.lines([
      "irb"
    ]),
}
