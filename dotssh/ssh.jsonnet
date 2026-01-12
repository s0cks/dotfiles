local ssh = import 'lib/ssh.libsonnet';
local GH_ID_RSA = std.extVar("GH_ID_RSA");

{
  "config":
    ssh.manifest(
      core = {
        AddKeysToAgent: 'yes',
      },
      hosts = 
        ssh.GitHubHost(ident = "~/.ssh/" + GH_ID_RSA),
    ),
}
