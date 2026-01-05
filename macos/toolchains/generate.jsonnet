local zsh = import 'lib/zsh.libsonnet';

local Toolchain(path, cc, cxx, ld, extras = {}) =
  zsh.manifest(
    [
      zsh.ExportPathPrepend(path),
      zsh.Export("CC", cc),
      zsh.Export("CXX", cxx),
      zsh.Export("LD", ld),
    ] +
    [
      zsh.Export(name, extras[name])
      for name in std.objectFields(extras)
    ]
  );

local LLVM_EXTRAS = { AR: "llvm-ar", RANLIB: "llvm-ranlib" };
local LLVMToolchain(path, cc = "clang", cxx = "clang++", ld = "ld.lld", extras = LLVM_EXTRAS) = 
  Toolchain(path, cc, cxx, ld, extras);

{
  ["homebrew-llvm"]:
    LLVMToolchain("$(brew --prefix llvm)/bin"), 
}
