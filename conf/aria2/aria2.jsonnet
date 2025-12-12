local GenerateCoreConf(install_dir) =
  (importstr "./templates/core.conf") % {
    install_dir: install_dir,
    max_concurrent_downloads: 5,
  };

local GenerateRpcConf(install_dir) = (importstr "./templates/rpc.conf") % {
  install_dir: install_dir,
  port: 6800,
  secret: std.extVar('ARIA2_SECRET'),
};

local GenerateHttpConf(install_dir) = (importstr "./templates/http.conf") % {
  install_dir: install_dir,
  user_agent: std.extVar("ARIA2_USER_AGENT"),
};

local peer = import './peer.json';
local torrent_trackers = std.strReplace((importstr "./trackers.txt"), '\n', ',');
local GenerateTorrentConf(install_dir) = (importstr "./templates/torrent.conf") % {
  install_dir: install_dir,
  peer_id_prefix: peer.id_prefix,
  peer_agent: peer.agent,
  trackers: torrent_trackers,
};

local GenerateAria2Conf(install_dir = '/usr/local/share/aria2') = |||
  # Core
  %(core)s
  # RPC
  %(rpc)s
  # HTTP/FTP/SFTP
  %(http)s
  # Torrent
  %(torrent)s
||| % { 
  core: GenerateCoreConf(install_dir),
  rpc: GenerateRpcConf(install_dir),
  http: GenerateHttpConf(install_dir),
  torrent: GenerateTorrentConf(install_dir),
};

{
  ["aria2.conf"]: GenerateAria2Conf(),
}
