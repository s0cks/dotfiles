local zsh = import 'lib/zsh.libsonnet';

local email = "tazz@tazz.cloud";
local gpg_key = "A7E49DD5";
local gpg_id = "tazz@tazz.cloud";

local Profile(useremail) =
  [
    zsh.Export("USEREMAIL", useremail),
  ];

local Gpg(id, key, tty = "$(tty)") =
  [
    zsh.Export("GPG_ID", id),
    zsh.Export("GPG_KEY", key),
    zsh.Export("GPG_TTY", tty), 
  ];

local LoadProfileSecrets =
  [
    "local ZPROFILE_SECRETS_FILE=\"${ZPROFILE_SECRETS_FILE:-$HOME/.zprofile_secrets.gpg}\"",
    "[[ -f \"$ZPROFILE_SECRETS_FILE\" ]] && source <(gpg --quiet --yes -d \"$ZPROFILE_SECRETS_FILE\")",
  ];

Profile(email) +
Gpg(gpg_id, gpg_key) +
LoadProfileSecrets
