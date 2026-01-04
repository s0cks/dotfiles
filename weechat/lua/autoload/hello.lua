weechat.register(
  'hello', --- Script Name
  's0cks', --- Author
  '1.0', --- Version
  'MIT', --- License
  'Integrate bitwarden into weechat', --- Description
  '', --- Shutdown func
  '' --- Charset
)

local UNDERNET = 'irc.undernet.org'
local CUFFLINK = 'irc.cuff-link.org'

local SERVERS = {
  undernet = UNDERNET,
  cufflink = CUFFLINK,
}

local X = 'X@channels.undernet.org'
local NICKSERV = 'NickServ'

local function message(buffer_ptr, nick, msg)
  if type(msg) == 'table' then
    msg = table.concat(msg, ' ')
  end
  weechat.command(buffer_ptr, '/msg ' .. nick .. ' ' .. msg)
end

local function mode(buffer_ptr, nick, m)
  weechat.command(buffer_ptr, '/mode ' .. nick .. ' ' .. m)
end

local function login2x(buffer_ptr, nick, pwd)
  message(buffer_ptr, X, { 'login', nick, pwd })
end

local function login2ns(buffer_ptr, nick, pwd)
  message(buffer_ptr, NICKSERV, { 'identify', nick, pwd })
end

function get_password_cb(data, command, return_code, out, err)
  if return_code ~= 0 then
    weechat.print('', 'failed to get pasword from gopass [' .. return_code .. ']: ' .. err)
    return weechat.WEECHAT_RC_ERROR
  end

  local server_name = nil
  if data == UNDERNET then
    server_name = 'undernet'
  elseif data == CUFFLINK then
    server_name = 'cufflink'
  end
  local server_buffer_name = 'server.' .. server_name
  local buffer_ptr = weechat.buffer_search('irc', server_buffer_name)
  if buffer_ptr == '' or buffer_ptr == '0x0' then
    weechat.print('', 'failed to find `' .. server_buffer_name .. '` buffer')
    return weechat.WEECHAT_RC_ERROR
  end

  weechat.print('', 'found password for ' .. data .. ': ' .. out)
  if data == UNDERNET then
    login2x(buffer_ptr, 'laceh', out)
    mode(buffer_ptr, 'laceh', '+x')
  elseif data == CUFFLINK then
    login2ns(buffer_ptr, 'laceh', out)
  end
  return weechat.WEECHAT_RC_OK
end

function get_password(server)
  weechat.print('', 'getting password from gopass for: ' .. server)
  local command = {
    'gopass',
    'show',
    '-o',
    'websites/' .. server .. '/laceh',
  }
  weechat.hook_process(table.concat(command, ' '), 0, 'get_password_cb', server)
end

function on_connected_cb(signal, signal_data, extra)
  weechat.print('', 'signal: ' .. signal)
  weechat.print('', 'signal_data: ' .. signal_data)
  weechat.print('', 'extra: ' .. extra)
  get_password(SERVERS[extra])
  return weechat.WEECHAT_RC_OK
end

weechat.hook_signal('irc_server_connected', 'on_connected_cb', '')
