local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local voices = { {text = 'Offering all sorts of magic equipment.'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    local player = Player(cid)
    local items = {[1] = 2190, [2] = 2182}
    local itemId = items[player:getVocation():getBase():getId()]

    if player:isMage() then
        if player:getStorageValue(Storage.firstMageWeapon) == -1 then
            npcHandler:say('So you ask me for a {' .. ItemType(itemId):getName() .. '} to begin your adventure?', cid)
            npcHandler.topic[cid] = 1
        else
            npcHandler:say('What? I have already given you one {' .. ItemType(itemId):getName() .. '}!', cid)
        end
    else
        npcHandler:say('Sorry, you aren\'t a druid or a sorcerer.', cid)
    end

    if msgcontains(msg, 'yes') then
        if npcHandler.topic[cid] == 1 then
            player:addItem(itemId, 1)
            npcHandler:say('Here you are young adept, take care yourself.', cid)
            player:setStorageValue(Storage.firstMageWeapon, 1)
        end
        npcHandler.topic[cid] = 0
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
        npcHandler:say('Ok then.', cid)
        npcHandler.topic[cid] = 0
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Be mourned pilgrim in flesh and welcome to the magic store.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May enlightenment be your path.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "May enlightenment be your path.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my wares. Or do you want to look only at wands or runes?")
npcHandler:addModule(FocusModule:new())
