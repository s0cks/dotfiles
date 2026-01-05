local zsh = import 'lib/zsh.libsonnet';
{
  [".zshenv"]: zsh.manifest(import 'lib/zshenv.libsonnet'),
  [".zaliases"]: zsh.manifest(import 'lib/zaliases.libsonnet'),
  [".zprofile"]: zsh.manifest(import 'lib/zprofile.libsonnet'),
  [".zimrc"]: zsh.manifest(import 'lib/zimrc.libsonnet'),
  [".zstyles"]: zsh.manifest(import 'lib/zstyles.libsonnet'),
  [".zshrc"]: zsh.manifest(import 'lib/zshrc.libsonnet'),
  [".zkeys"]: zsh.manifest(import 'lib/zkeys.libsonnet'),
}
