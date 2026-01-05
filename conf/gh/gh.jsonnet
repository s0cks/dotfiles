local util = import 'lib/util.libsonnet';

local config =
  {

  };

local HostConfig(name, user, protocol, users = []) =
  {
    [name]:   {
      user: user,
      git_protocol: protocol,
      users: [ user ] + users,
    },
  };
local SSH = "ssh";
local SshHostConfig(name, user, users = []) =
  HostConfig(user, SSH, users);

local GITHUB = "github.com";
local GitHubHostConfig(user, protocol, users = []) =
  HostConfig(GITHUB, user, protocol, users);
local GitHubSSHHostConfig(user, users = []) =
  GitHubHostConfig(user, SSH, users);

local GitProtocol(value) = {
  git_protocol: value,
};
local HTTPS = "https";
local HttpsGitProtocol = GitProtocol(HTTPS);
local SSHGitProtocol = GitProtocol(SSH);

local Aliases(aliases) =
  {
    // Aliases allow you to create nicknames for gh commands
    aliases: aliases,
  };

local Config(editor = "", pager = "", browser = "", http_unix_socket = "", prompt = "enabled", version = '1') = 
  {
    version: "1",
    // What editor gh should run when creating issues, pull requests, etc. If blank, will refer to environment.
    editor: editor,
    // When to interactively prompt. This is a global config that cannot be overridden by hostname. Supported values: enabled, disabled
    prompt: prompt,
    // A pager program to send command output to, e.g. "less". Set the value to "cat" to disable the pager.
    pager: pager,
    // The path to a unix socket through which send HTTP connections. If blank, HTTP traffic will be handled by net/http.DefaultTransport.
    http_unix_socket: http_unix_socket,
    // What web browser gh should use when opening URLs. If blank, will refer to environment.
    browser: browser,
  };

local config =
  Config() +
  SSHGitProtocol +
  Aliases({
    co: "pr checkout",
  });
local hosts = GitHubSSHHostConfig("s0cks");

{
  ["config.yml"]:
    std.lines(util.WarningHeaderComment()) + 
    std.manifestYamlDoc(config, true, false),
  ["hosts.yml"]:
    std.lines(util.WarningHeaderComment()) + 
    std.manifestYamlDoc(hosts, true, false),
}
