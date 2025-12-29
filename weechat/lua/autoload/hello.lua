weechat.register(
  "hello", --- Script Name
  "s0cks", --- Author
  "1.0", --- Version
  "MIT", --- License
  "Integrate bitwarden into weechat", --- Description
  "", --- Shutdown func
  "" --- Charset
)

function rbw_get_cb(data, command, return_code, out, err)
  weechat.print("", "data: " .. data)
  if return_code == 0 then
    weechat.print("", "STDOUT: " .. out)
    weechat.print("", "STDERR: " .. err)
  else
    weechat.print("", "command " .. command .. " finished with return code: " .. return_code)
  end
  return weechat.WEECHAT_RC_OK
end

function on_connected_cb(signal, signal_data, extra)
  weechat.print("", "connected to: " .. signal .. " " .. signal_data .. " " .. extra)
  local command = {
    "rbw",
    "get",
    "Undernet",
  }
  local cmd = table.concat(command, " ")
  local hook = weechat.hook_process(cmd, 0, "rbw_get_cb", "")
  return weechat.WEECHAT_RC_OK
end

weechat.hook_signal("irc_server_connected", "on_connected_cb", "")
