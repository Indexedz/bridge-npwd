local player = import '@Index/player'
local server = import '@Index/server'

local function loadPlayer(xPlayer, xCharacter)
  local info = xCharacter.info;
  local payload = {
    source = xPlayer.source,
    identifier = xCharacter.charId,
    phoneNumber = xCharacter.get("phone"),
    firstname = info.firstName,
    lastname = info.lastName,
  }
  
  return exports.npwd:newPlayer(payload)
end

server.on('@player:ready', function (src)
  loadPlayer(player.find(src))
end)

server.on("@player:logout", function (src)
  exports.npwd:unloadPlayer(src)
end)

AddEventHandler('onServerResourceStart', function(resourceName)
  if resourceName ~= global.resource then
    return
  end

  player.all(loadPlayer)
end)