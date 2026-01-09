local ssh = import 'lib/ssh.libsonnet';

{
  "config":
    ssh.manifest(
      core = {
        AddKeysToAgent: 'yes',
      },
      hosts = 
        ssh.GitHubHost(),
    ),
}
