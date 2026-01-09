local ssh = import 'lib/ssh.libsonnet';
local hosts = import 'hosts.json';

local CreateHost(name, config) = 
  ssh.Host(config.hostname, config.user, name) +
  (if "ident" in config then
    ssh.HostPublicKeyIdent(config.ident)
  else
    {});

{
  "config":
    ssh.manifest(
      [
        ssh.Property('AddKeysToAgent', 'yes')
      ],
      [
        CreateHost(name, hosts[name])
        for name in std.objectFields(hosts)
      ]
    )
}
