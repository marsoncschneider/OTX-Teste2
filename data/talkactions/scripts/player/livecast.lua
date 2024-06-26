function onSay(player, words, param)
    local storage = 17754 -- exp storage

	if player:getStorageValue(Storage.CastDelay) > os.stime() then
		player:sendCancelMessage("You are exhausted.")
		return false
	end

	player:setStorageValue(Storage.CastDelay, os.stime() + 10)
	if player:startLiveCast(param) then
		player:say("CAST ON", TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have started casting your gameplay.")
		player:setStorageValue(storage, 1)
	elseif player:stopLiveCast(param) then
		player:say("CAST OFF", TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have stopped casting your gameplay.")
		player:setStorageValue(storage, 0)
	end
	return false
end