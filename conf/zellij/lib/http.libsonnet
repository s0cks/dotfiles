local kdl = import 'lib/kdl.libsonnet';
local util = import 'lib/util.libsonnet';

{
  Config(enabled, ip = "127.0.0.1", port = 8082, enforce_https_for_localhost = false): |||
      %(header)s
      %(properties)s
      %(client)s
    ||| % {
    header: kdl.BlockComment("Http Configuration"),
    properties: std.lines([
      // Whether to make sure a local web server is running when a new Zellij session starts.
      // This web server will allow creating new sessions and attaching to existing ones that have
      // opted in to being shared in the browser.
      // When enabled, navigate to http://127.0.0.1:8082
      // (Requires restart)
      // Note: a local web server can still be manually started from within a Zellij session or from the CLI.
      // If this is not desired, one can use a version of Zellij compiled without
      // `web_server_capability`
      // 
      // Possible values:
      // - true
      // - false
      kdl.Property('web_server', enabled),

      // Whether to allow sessions started in the terminal to be shared through a local web server, assuming one is
      // running (see the `web_server` option for more details).
      // (Requires restart)
      // 
      // Note: This is an administrative separation and not intended as a security measure.
      // 
      // Possible values:
      // - "on" (allow web sharing through the local web server if it
      // is online)
      // - "off" (do not allow web sharing unless sessions explicitly opt-in to it)
      // - "disabled" (do not allow web sharing and do not permit sessions started in the terminal to opt-in to it)
      kdl.Property('web_sharing', 'off'),

      // A path to a certificate file to be used when setting up the web client to serve the
      // connection over HTTPs
      // kdl.Property('web_server_cert', '/path/to/cert.pem'),

      // A path to a key file to be used when setting up the web client to serve the
      // connection over HTTPs
      // kdl.Property('web_server_key'), '/path/to/key.pem'),


      /// Whether to enforce https connections to the web server when it is bound to localhost
      /// (127.0.0.0/8)
      ///
      /// Note: https is ALWAYS enforced when bound to non-local interfaces
      kdl.Property('enforce_https_for_localhost', enforce_https_for_localhost),

      // The ip address the web server should listen on when it starts
      // Default: "127.0.0.1"
      // (Requires restart)
      kdl.Property('web_server_ip', ip),

      // The port the web server should listen on when it starts
      // Default: 8082
      // (Requires restart)
      kdl.Property('web_server_port', port),
    ]),
    client: kdl.Section('web_client', [
      kdl.Property('font', 'monospace'),
    ]),
  },
  DisabledConfig: self.Config(false),
}
