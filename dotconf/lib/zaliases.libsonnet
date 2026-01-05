local zsh = import 'lib/zsh.libsonnet';
// misc
(import 'lib/aliases/misc.libsonnet') +
// eza
(import 'lib/aliases/eza.libsonnet') +
// gpg
(import 'lib/aliases/gpg.libsonnet') +
// editor
(import 'lib/aliases/editor.libsonnet') +
// suffix aliases
(import 'lib/aliases/suffix.libsonnet') +
// global aliases
(import 'lib/aliases/global.libsonnet') +
// hashes
(import 'lib/aliases/hashes.libsonnet')
