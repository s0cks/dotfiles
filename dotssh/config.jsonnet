local GenHostSection(name, hostname, user, ident) = |||
  Host %(name)s
    Hostname %(hostname)s
    User %(user)s
    PreferredAuthentications publickey
    IdentityFile %(ident)s
    UseKeychain yes
||| % { name: name, hostname: hostname, user: user, ident: ident };

local GenHostsSection(hosts) = std.join('\n', [
  GenHostSection(name, hosts[name].hostname, hosts[name].user, hosts[name].ident)
  for name in std.objectFields(hosts)
]);

local GenSSHConfig() =
  (importstr './_config') % {
    hosts: GenHostsSection((import './hosts.json')),
  };

{
  "config": GenSSHConfig(),
}
