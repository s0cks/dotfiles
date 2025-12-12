local versions = [
  "21", "20", "19"
];

local LLVMToolchain(version = '21') = |||
  #!/usr/bin/env zsh
  brew unlink llvm
  LLVM_PACKAGE_VERSION="llvm@%(version)s"
  brew link "$LLVM_PACKAGE_VERSION"
  export LLVM_HOME="$(brew --prefix "$LLVM_PACKAGE_VERSION")"
  echo "enabling homebrew $LLVM_PACKAGE_VERSION...."
  export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
  export CMAKE_PREFIX_PATH="$LLVM_HOME"
  export LD_LIBRARY_PATH="$LLVM_HOME/lib/:$LD_LIBRARY_PATH"
  export DYLD_LIBRARY_PATH="$LLVM_HOME/lib/:$DYLD_LIBRARY_PATH"
  export CPATH="$LLVM_HOME/lib/clang/%(version)s/include/"
  export LDFLAGS="-L$LLVM_HOME/lib"
  export CPPFLAGS="-I$LLVM_HOME/include"
  export CC="clang"
  export CXX="clang++"
  export PATH="$LLVM_HOME/bin:$PATH"
  LLVM_FULL_VERSION=$(brew info --json "$LLVM_PACKAGE_VERSION" | jq -r ".[].versions.stable")
  echo " enabled homebrew $LLVM_PACKAGE_VERSION ($LLVM_FULL_VERSION) from $LLVM_HOME"
||| % {version: version};
{
  ["llvm%(version)s" % {version: version}]: LLVMToolchain(version),
  for version in versions
}
