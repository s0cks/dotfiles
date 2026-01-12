local GPG_EXEC = std.extVar("GPG_EXEC");

local GenerateGitConfig() =
  (importstr './templates/config') % { };

local GenBasicUserConfig(name, email) =
  (importstr './templates/basic.user.gitconfig') % {
    name: name,
    email: email,
  };

local GenSignedUserConfig(name, email, key) =
  (importstr './templates/signed.user.gitconfig') % {
    name: name,
    email: email,
    key: key,
    gpg_exec: GPG_EXEC,
  };

local GenUserConfig(user) = 
  if "key" in user then
    GenSignedUserConfig(user.name, user.email, user.key)
  else
    GenBasicUserConfig(user.name, user.email);

local users = import './users.json';
{
  ["config"]: GenerateGitConfig(),
}
+
{
  ["%(name)s.gitconfig" % { name: user.name }]: GenUserConfig(user),
  for user in users
}
