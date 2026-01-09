local zsh = import 'lib/zsh.libsonnet';
local util = import 'lib/util.libsonnet';

{
  Toolchain(path,
            cc,
            cxx,
            ld,
            extras = {}):
    zsh.manifest(
      [
        zsh.ExportPathPrepend(path),
        zsh.Exports({
          CC: cc,
          CXX: cxx,
          LD: ld,
        })
      ] +
      [
        zsh.Export(name, extras[name])
        for name in std.objectFields(extras)
      ]),
  local DEFAULT_LLVM_CC = "clang",
  local DEFAULT_LLVM_CXX = "clang++",
  local DEFAULT_LLVM_LD = "ld.lld",
  local DEFAULT_LLVM_EXTRAS = { AR: "llvm-ar", RANLIB: "llvm-ranlib" },
  LLVMToolchain(path,
                cc = DEFAULT_LLVM_CC,
                cxx = DEFAULT_LLVM_CXX,
                ld = DEFAULT_LLVM_LD,
                extras = DEFAULT_LLVM_EXTRAS):
    $.Toolchain(path, cc, cxx, ld, extras),
  HomebrewLLVMToolchain(path = util.BrewPrefixPath("llvm"),
                        cc = DEFAULT_LLVM_CC,
                        cxx = DEFAULT_LLVM_CXX,
                        ld = DEFAULT_LLVM_LD,
                        extras = DEFAULT_LLVM_EXTRAS):
    $.LLVMToolchain(path, cc, cxx, ld, extras),
}
