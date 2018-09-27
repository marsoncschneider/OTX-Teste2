function Item.getParentPlayer(self)
	local parent = self:getParent()
	if not parent then
		return false
	end
	if parent:isItem() then
		return parent:getParentPlayer()
	else
		return parent
	end
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	if (not player) then
		return false
	end
	if not itemEx:isItem() then
		return false
	end
	local pEx = itemEx:getParentPlayer()
	if not pEx or not Player(pEx) or pEx:getId() ~= player:getId() then
		player:sendCancelMessage('Sorry, is not possible.')
		return true
	end
	player:openImbuementWindow(itemEx)

	return true
end
