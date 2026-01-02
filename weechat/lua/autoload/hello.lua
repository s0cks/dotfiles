weechat.register(
  "hello", --- Script Name
  "s0cks", --- Author
  "1.0", --- Version
  "MIT", --- License
  "Integrate bitwarden into weechat", --- Description
  "", --- Shutdown func
  "" --- Charset
)

local X = "X@channels.undernet.org"
function get_password_cb(data, command, return_code, out, err)
  if return_code ~= 0 then
    weechat.print("", "failed to get pasword from gopass [" .. return_code .. "]: " .. err)
    return weechat.WEECHAT_RC_ERROR
  end

  weechat.print("", "retrieved password from gopass: " .. out)
  local buffer_ptr = weechat.buffer_search("irc", "server.undernet")
  if buffer_ptr == "" or buffer_ptr == "0x0" then
    weechat.print("", "failed to find buffer for undernet server")
    return weechat.WEECHAT_RC_ERROR
  else
    weechat.command(buffer, "/msg " .. X .. " login laceh " .. out)
    weechat.command(buffer, "/mode laceh +x")
  end
  return weechat.WEECHAT_RC_OK
end

function get_password()
  local command = {
    "gopass",
    "show",
    "-o",
    "websites/irc.undernet.org/laceh",
  }
  weechat.hook_process(table.concat(command, " "), 0, "get_password_cb", "")
end

function on_connected_cb(signal, signal_data, extra)
  get_password()
  return weechat.WEECHAT_RC_OK
end

weechat.hook_signal("irc_server_connected", "on_connected_cb", "Undernet")
