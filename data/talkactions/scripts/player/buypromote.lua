local vocations = {
    [1] = 5,
    [2] = 6,
    [3] = 7,
    [4] = 8,
}


function onSay(player, words, param)
       local vocation = player:getVocation()
       local vocID = vocation:getId()
       local PromotionPrice = 20000
       if vocations[vocID] then
       if player:removeMoney(PromotionPrice) then
       player:setVocation(Vocation(vocations[vocID]))
       player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been promoted!.")
       player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    else
    player:sendCancelMessage("Sorry, You don't have enough money.")
    end
    else
    player:sendCancelMessage("Sorry, you are already promoted.")
    end
    return true
end