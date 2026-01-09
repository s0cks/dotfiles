local zsh = import 'lib/zsh.libsonnet';

local email = "tazz@tazz.cloud";
local gpg_key = "A7E49DD5";
local gpg_id = "tazz@tazz.cloud";

local Profile(useremail) =
  zsh.Exports({
    USEREMAIL: useremail,
  }, false, true);

local Gpg(id, key, tty = "$(tty)") =
  zsh.Exports({
    GPG_ID: id,
    GPG_KEY: key,
    GPG_TTY: tty,
  }, false, true);

local ProfileSecretsFragment = |||
  ZPROFILE_SECRETS_FILE="${ZPROFILE_SECRETS_FILE:-$HOME/.zprofile_secrets.gpg}"
  zsecrets-reload() { eval "$(gpg --quiet --yes -d $ZPROFILE_SECRETS_FILE)" }
  [[ -f "$ZPROFILE_SECRETS_FILE" ]] && zsecrets-reload
|||;

local ProfileSecrets = std.split(ProfileSecretsFragment, "\n");

Profile(email) +
Gpg(gpg_id, gpg_key) +
ProfileSecrets
