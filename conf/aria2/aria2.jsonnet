local GenerateCoreConf(install_dir) =
  (importstr "./_core.conf") % {
    install_dir: install_dir,
    max_concurrent_downloads: 5,
  };

local GenerateRpcConf(install_dir) = (importstr "./_rpc.conf") % {
  install_dir: install_dir,
  port: 6800,
  secret: std.extVar('ARIA2_SECRET'),
};

local GenerateHttpConf(install_dir) = (importstr "./_http.conf") % {
  install_dir: install_dir,
};

local peer = import './peer.json';
local torrent_trackers = std.strReplace((importstr "./trackers.txt"), '\n', ',');
local GenerateTorrentConf(install_dir) = (importstr "./_torrent.conf") % {
  install_dir: install_dir,
  peer_id_prefix: peer.id_prefix,
  peer_agent: peer.agent,
  trackers: torrent_trackers,
};

local GenerateAria2Conf(install_dir = '/usr/local/share/aria2') =
  (importstr './_aria2.conf') % { 
    core: GenerateCoreConf(install_dir),
    rpc: GenerateRpcConf(install_dir),
    http: GenerateHttpConf(install_dir),
    torrent: GenerateTorrentConf(install_dir),
  };

{
  ["aria2.conf"]: GenerateAria2Conf(),
}
