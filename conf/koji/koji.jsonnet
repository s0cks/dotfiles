local koji = import 'lib/koji.libsonnet';

{
  ["config.toml"]:
    koji.manifest(
      koji.Config() +
      koji.CommitTypes([
        koji.CommitType('feat', '✨', 'A new feature'),
        koji.CommitType('fix', '🐛', 'A bug fix'),
        koji.CommitType('docs', '📚', 'Documentation only changes'),
        koji.CommitType('style', '💄', 'Changes that do not affect the meaning of the code'),
        koji.CommitType('refactor', '🔨', 'A code change that neither fixes a bug nor adds a feature'),
        koji.CommitType('perf', '⚡', 'A code change that improves performance'),
        koji.CommitType('test', '🚨', 'Adding missing tests or correcting existing tests'),
        koji.CommitType('build', '📦', 'Changes that affect the build system or external dependencies'),
        koji.CommitType('ci', '🤖', 'Changes to our CI configuration files and scripts'),
        koji.CommitType('chore', '🧹', "Other changes that don't modify src or test files"),
        koji.CommitType('revert', "⏪", "Reverts a previous commit"),
      ])),
}
