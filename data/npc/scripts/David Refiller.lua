 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)	npcHandler:onCreatureAppear(cid)	end
function onCreatureDisappear(cid)npcHandler:onCreatureDisappear(cid)	end
function onCreatureSay(cid, type, msg)npcHandler:onCreatureSay(cid, type, msg)end
function onThink()npcHandler:onThink()	end


local options = {
	['potions'] = {
		{name = 'lifefluid', id = 7618, buy = 45},
		{name = 'manafluid', id = 7620, buy = 50}	
	},
	['runes'] = {
		{name = "black pearl", id = 2144, buy = 280},
		{name = "bronze goblet", id = 5807, buy = 2000},
		{name = "supreme health potion", id = 26031, buy = 500},
	},
	['equipment'] = {
		{name = "axe", id = 2386, buy = 20},
		{name = "battle axe", id = 2378, buy = 235},
		{name = "battle hammer", id = 2417, buy = 350},
		{name = "bone sword", id = 2450, buy = 75},
		{name = "brass armor", id = 2465, buy = 450},
		{name = "brass helmet", id = 2460, buy = 120},
		{name = "brass legs", id = 2478, buy = 195},
		{name = "brass shield", id = 2511, buy = 65},
		{name = "carlin sword", id = 2395, buy = 473},
		{name = "chain armor", id = 2464, buy = 200},
		{name = "chain helmet", id = 2458, buy = 52},
		{name = "chain legs", id = 2648, buy = 80},
		{name = "club", id = 2382, buy = 5},
		{name = "coat", id = 2651, buy = 8},
		{name = "crowbar", id = 2416, buy = 260},
		{name = "dagger", id = 2379, buy = 5},
		{name = "doublet", id = 2485, buy = 16},
		{name = "dwarven shield", id = 2525, buy = 500},
		{name = "hand axe", id = 2380, buy = 8},
		{name = "iron helmet", id = 2459, buy = 390},
		{name = "jacket", id = 2650, buy = 12},
		{name = "leather armor", id = 2467, buy = 35},
		{name = "leather boots", id = 2643, buy = 10},
		{name = "leather helmet", id = 2461, buy = 12},
		{name = "leather legs", id = 2649, buy = 10},
		{name = "longsword", id = 2397, buy = 160},
		{name = "mace", id = 2398, buy = 90},
		{name = "morning star", id = 2394, buy = 430},
		{name = "plate armor", id = 2463, buy = 1200},
		{name = "plate shield", id = 2510, buy = 125},
		{name = "rapier", id = 2384, buy = 15},
		{name = "sabre", id = 2385, buy = 35},
		{name = "scale armor", id = 2483, buy = 260},
		{name = "short sword", id = 2406, buy = 26},
		{name = "sickle", id = 2405, buy = 7},
		{name = "soldier helmet", id = 2481, buy = 110},
		{name = "spike sword", id = 2383, buy = 8000},
		{name = "steel helmet", id = 2457, buy = 580},
		{name = "steel shield", id = 2509, buy = 240},
		{name = "studded armor", id = 2484, buy = 90},
		{name = "studded helmet", id = 2482, buy = 63},
		{name = "studded legs", id = 2468, buy = 50},
		{name = "studded shield", id = 2526, buy = 50},
		{name = "throwing knife", id = 2410, buy = 25},
		{name = "two handed sword", id = 2377, buy = 950},
		{name = "viking helmet", id = 2473, buy = 265},
		{name = "viking shield", id = 2531, buy = 260},
		{name = "war hammer", id = 2391, buy = 10000},
		{name = "wooden shield", id = 2512, buy = 15}
	},
	['distance'] = {
		{name = "arrow", id = 2544, buy = 3},
		{name = "bolt", id = 2543, buy = 4},
		{name = "bow", id = 2456, buy = 400},
		{name = "crossbow", id = 2455, buy = 400},


		{name = "diamond arrow", id = 29057, buy = 100},






		{name = "power bolt", id = 2547, buy = 7},



		{name = "spear", id = 2389, buy = 9},

		{name = "throwing knife", id = 2410, buy = 25},
		{name = "throwing star", id = 2399, buy = 42},
		{name = "quiver", id = 40965, buy = 100},
		{name = "blue quiver", id = 41242, buy = 400},
		{name = "red quiver", id = 41243, buy = 400},
		{name = "jungle quiver", id = 40927, buy = 10000}
	},
	['supplies'] = {
		{name = "white mushroom", id = 2787, buy = 6},
		{name = "brown mushroom", id = 2789, buy = 10},
		{name = "red mushroom", id = 2788, buy = 12},
		{name = "bread", id = 2689, buy = 4},
		{name = "ham", id = 2671, buy = 8},
		{name = "cheese", id = 2696, buy = 6},
		{name = "meat", id = 2666, buy = 5}
	},
	['tools'] = {
		{name = "backpack", id = 1988, buy = 20},
		{name = "bag", id = 1987, buy = 5},
		{name = "BUNDA", id = 2580, buy = 150},
		{name = "machete", id = 2420, buy = 40},
		{name = "pick", id = 2553, buy = 50},
		{name = "present", id = 1990, buy = 10},
		{name = "rope", id = 2120, buy = 50},
		{name = "scroll", id = 1949, buy = 5},
		{name = "scythe", id = 2550, buy = 50},
		{name = "shovel", id = 2554, buy = 50},
		{name = "torch", id = 2050, buy = 2},
		{name = "watch", id = 6091, buy = 20},
		{name = "worm", id = 3976, buy = 1}
	},
	['postal'] = {
		{name = "label", id = 2599, buy = 1},
		{name = "parcel", id = 2595, buy = 15},
		{name = "letter", id = 2597, buy = 8}
	},
	['rods'] = {








	},
	['wands'] = {








	},
	['various'] = {






	}
}

local equivalente = {
	[1] = 'potions',
	[2] = 'runes',
	[3] = 'equipment',
	[4] = 'distance',
	[5] = 'supplies',
	[6] = 'tools',
	[7] = 'rods',
	[8] = 'wands',
	[9] = 'various',
}

local function getTable(player)
	local msg = equivalente[player:getStorageValue(Storage.NPCTable)]
	if not msg then
		return false
	end

	local itemsList = {}
	local sendTrade = options[msg:lower()]
	if not sendTrade then return false end

	itemsList = sendTrade
	return itemsList
end

local function setNewTradeTable(_table)
	local items, item = {}
	if _table then
		for i = 1, #_table do
			item = _table[i]
			items[item.id] = {itemId = item.id, buyPrice = item.buy, sellPrice = item.sell, subType = 0, realName = item.name, type = item.type, charges = item.charges}
		end
	end
	return items
end

local function onBuy(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	if not player then
		return false
	end

	if not getTable(player) then
		return false
	end

	local items = setNewTradeTable(getTable(player))
	if items then
		if not ignoreCap and player:getFreeCapacity() < ItemType(items[item].itemId):getWeight(amount) then
			return player:sendTextMessage(MESSAGE_INFO_DESCR, 'You don\'t have enough cap.')
		end
		if not player:removeMoneyNpc(items[item].buyPrice * amount) then
			selfSay("You don't have enough money.", cid)
		else
			local itemType = ItemType(items[item].itemId)
			if itemType:isStackable() then
				local item_ = player:addItem(items[item].itemId, amount)
				if item_ then
					if items[item].type and items[item].type == 'chargable' then
						item_:setAttribute(ITEM_ATTRIBUTE_CHARGES, items[item].charges)
					end
				end
			else
				for i = 1, amount do
					local it = player:addItem(itemType:getId(), subType)
					if it then
						if items[item].type and items[item].type == 'chargable' then
							it:setAttribute(ITEM_ATTRIBUTE_CHARGES, items[item].charges)
						end
					end
				end
			end

			return player:sendTextMessage(MESSAGE_INFO_DESCR, 'Bought '..amount..'x '..items[item].realName..' for '..items[item].buyPrice * amount..' gold coins.')
		end
	end
	return true
end

local function onSell(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	if not player then
		return false
	end

	if not getTable(player) then
		return false
	end

	local items = setNewTradeTable(getTable(player))
	if items[item].sellPrice and player:removeItem(items[item].itemId, amount) then
		player:addMoney(items[item].sellPrice * amount)
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'Sold '..amount..'x '..items[item].realName..' for '..items[item].sellPrice * amount..' gold coins.')
	else
		selfSay("You don't have item to sell.", cid)
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	player:setStorageValue(Storage.NPCTable, -1)
	for i = 1, #equivalente do
		if msgcontains(equivalente[i], msg) then
			player:setStorageValue(Storage.NPCTable, i)
			local items = setNewTradeTable(getTable(player))

			openShopWindow(cid, getTable(player), onBuy, onSell)
			npcHandler:say('Alright, here\'s all the ' .. equivalente[i] .. ' I can order for you!', cid)
			break
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye. :)')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
