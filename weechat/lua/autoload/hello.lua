weechat.register(
  "hello", --- Script Name
  "s0cks", --- Author
  "1.0", --- Version
  "MIT", --- License
  "Integrate bitwarden into weechat", --- Description
  "", --- Shutdown func
  "" --- Charset
)

function on_connected_cb(signal, signal_data, extra)
  weechat.print("", "connected to: " .. signal .. " " .. signal_data .. " " .. extra)
  return weechat.WEECHAT_RC_OK
end

weechat.hook_signal("irc_server_connected", "on_connected_cb", "")
