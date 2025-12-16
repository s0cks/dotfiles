local GenerateGitConfig() =
  (importstr './templates/config') % { };

local GenBasicUserConfig(name, email) =
  (importstr './templates/basic.user.gitconfig') % {
    name: name,
    email: email,
  };

local GPG_EXEC = "/opt/homebrew/bin/gpg";
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
