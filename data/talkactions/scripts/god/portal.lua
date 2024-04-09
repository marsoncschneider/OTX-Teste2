function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end
 
    local split = param:split(",")
    if split[3] == nil then
        player:sendCancelMessage("Insufficient parameters.")
        return false
    end
 
    x = split[1]
    y = split[2]
    z = split[3]
 
    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z)
 
    local DIR = player:getDirection()
 
    if DIR == DIRECTION_NORTH then
        portal_pos = {x = player:getPosition().x, y = player:getPosition().y - 1, z = player:getPosition().z}
    elseif DIR == DIRECTION_EAST then
        portal_pos = {x = player:getPosition().x + 1, y = player:getPosition().y, z = player:getPosition().z}
    elseif DIR == DIRECTION_SOUTH then
        portal_pos = {x = player:getPosition().x, y = player:getPosition().y + 1, z = player:getPosition().z}
    elseif DIR == DIRECTION_WEST then
        portal_pos = {x = player:getPosition().x - 1, y = player:getPosition().y, z = player:getPosition().z}
    end
 
    if isCreature(Tile(portal_pos):getTopCreature()) then
        return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You cannot create a teleport on top of a player.")
    end
 
    if Tile(portal_pos):getTopDownItem() then
        return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You cannot create a teleport on top of an item.")
    end
 
    doCreateTeleport(1387, {x = x, y = y, z = z}, portal_pos)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Teleport created to cordinates: {X: "..x.." Y: "..y.." Z: "..z.."}.")
    return false
end