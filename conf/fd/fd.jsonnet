local fd = import 'lib/fd.libsonnet';

{
  ["ignore"]:
    fd.manifest([
      fd.VersionControl(),
      fd.Nodejs(),
      fd.Python(),
      fd.Java(),
      fd.Rust(),
      fd.Go(),
      fd.Ruby(),
      fd.PHP(),
      fd.CC(),
      fd.Logs(),
      fd.MacOS(),
      fd.Editors(),
      fd.Testing(),
    ]),
}
