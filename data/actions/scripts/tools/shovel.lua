local config = {
    swampId = {20230, 18589, 18584, 18141}, -- ids dos tiles de swamp que pode ser usado a shovel
    itemGain = {{itemId = 2818, quantGain = 1}, -- itemid que ganha, e quantidade maxima do msm.
                {itemId = 2145, quantGain = 3},
                {itemId = 20138, quantGain = 1}
                }
}

local exhausth = 3600 --em quantos segundos podera usar denovo




local holes = {468, 481, 483, 7932, 23712}
local pools = {2016, 2017, 2018, 2019, 2020, 2021, 2025, 2026, 2027, 2028, 2029, 2030}
function onUse(cid, item, fromPosition, itemEx, toPosition)
beto(cid, toPosition)
digo(cid, toPosition)
charles(cid, toPosition)
if isInArray(pools, itemEx.itemid) then
        itemEx = Tile(toPosition):getGround()
    end
    if(isInArray(config.swampId, itemEx.itemid)) then
        if (getPlayerStorageValue(cid, 32901) <= os.time()) then
        if math.random(0,500) > 255 then
            local posGain = math.random(1, #config.itemGain)
            local quantGain = math.random(1,config.itemGain[posGain].quantGain)
            doPlayerAddItem(cid, config.itemGain[posGain].itemId, quantGain)
            doSendMagicEffect(toPosition, 8)
            doCreatureSay(cid,  "You dug up ".. quantGain .." ".. getItemName(config.itemGain[posGain].itemId) ..".", TALKTYPE_ORANGE_1)  
            setPlayerStorageValue(cid, 32901, os.time()+exhausth)  
        end
    else
            doPlayerSendCancel(cid, "You are exhausted, use again in 1 hour.")
        end
    else
        return shovelNormal(cid, item, fromPosition, itemEx, toPosition)
    end
    return true
end

function beto(cid, pos)
local tilepos1 = {x=33065, y=32423, z=10} --32024, 32830, 4
if(getPlayerStorageValue(cid, 1826) < 1 and pos.x == tilepos1.x and pos.y == tilepos1.y and pos.z == tilepos1.z) then
doPlayerAddItem(cid, 21401, 1)
setPlayerStorageValue(cid, 1826, 1)
doSendMagicEffect(tilepos1,CONST_ME_DRAWBLOOD)
return true
end

end

function digo(cid, pos)
local tilepos2 = {x=33061, y=32428, z=10} --32024, 32830, 4
if(getPlayerStorageValue(cid, 1827) < 1 and pos.x == tilepos2.x and pos.y == tilepos2.y and pos.z == tilepos2.z) then
doPlayerAddItem(cid, 21401, 1)
setPlayerStorageValue(cid, 1827, 1)
doSendMagicEffect(tilepos2,CONST_ME_DRAWBLOOD)
return true
end

end

function charles(cid, pos)
local tilepos3 = {x=33064, y=32435, z=10} --32024, 32830, 4
if(getPlayerStorageValue(cid, 1828) < 1 and pos.x == tilepos3.x and pos.y == tilepos3.y and pos.z == tilepos3.z) then
doPlayerAddItem(cid, 21401, 1)
setPlayerStorageValue(cid, 1828, 1)
doSendMagicEffect(tilepos3,CONST_ME_DRAWBLOOD)
return true
end

end


function shovelNormal(cid, item, fromPosition, itemEx, toPosition)
local target = itemEx
    local player = Player(cid)
    local iEx = Item(itemEx.uid)
    if isInArray(holes, itemEx.itemid) then
        iEx:transform(itemEx.itemid + 1)
        iEx:decay()
 elseif isInArray(pools, target.itemid) then
        local hole = 0
        for i = 1, #holes do
            local tile = Tile(target:getPosition()):getItemById(holes[i])
            if tile then
                hole = tile
            end
        end
        if hole ~= 0 then
            hole:transform(hole:getId() + 1)
            hole:decay()
        else
            return false
        end   
	elseif(itemEx.actionid  == 4205 and player:getStorageValue(3938) == 1) then -- Into the Pit Bone Quest
		target:getPosition():sendMagicEffect(CONST_ME_POFF)
        Game.createItem(2248, 1, Position(target:getPosition()))
addEvent(function()
	local tile = Tile(Position(target:getPosition()))
	if (tile and tile:getItemCountById(2248)) > 0 then
	tile:getItemById(2248):remove()
 end
end, 60000)
	elseif(itemEx.actionid  == 1345 and player:getStorageValue(12690) >= 2) then -- Aritos Task
		target:getPosition():sendMagicEffect(CONST_ME_POFF)
        iEx:transform(489)
        iEx:decay()						 
    elseif itemEx.itemid == 231 or itemEx.itemid == 9059 or itemEx.itemid == 22672 then
        local rand = math.random(1, 100)
        if(itemEx.actionid  == 100 and rand <= 20) then
        iEx:transform(489)
        iEx:decay()
        elseif rand == 1 then
            Game.createItem(2159, 1, toPosition)
        elseif rand > 95 then
            Game.createMonster("Rat", toPosition)
        end
        toPosition:sendMagicEffect(CONST_ME_POFF)
    elseif itemEx.actionid == 4654 and player:getStorageValue(9925) == 1 and player:getStorageValue(9926) < 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You found a piece of the scroll. You pocket it quickly.')
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:addItem(21250, 1)
        player:setStorageValue(9926, 1)
    elseif itemEx.actionid == 4668 and player:getStorageValue(12902) == 1 and player:getStorageValue(12903) < 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'A torn scroll piece emerges. Probably gnawed off by rats.')
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:addItem(21250, 1)
        player:setStorageValue(12903, 1)
    else
        return false
    end
    return true
end