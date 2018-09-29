function onStepIn(creature, item, position, fromPosition)
	if item:getPosition() == Position(32075, 31900, 5) then
		creature:teleportTo(Position(32075, 31899, 5), true)
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, '<krrk> <krrrrrk> You move away hurriedly.')
		return true
	end
		
	item:transform(item.itemid + 1)
	item:decay()
	return true
end
