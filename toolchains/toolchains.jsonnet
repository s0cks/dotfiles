local toolchains = import 'lib/toolchains.libsonnet';

{
  ["homebrew-llvm"]: toolchains.HomebrewLLVMToolchain(),
}
