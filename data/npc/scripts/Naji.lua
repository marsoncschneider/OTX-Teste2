local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local count = {}
local transfer = {}

function onCreatureAppear(cid)          npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()      npcHandler:onThink()        end

-- local voices = { {text = 'Don\'t forget to deposit your money here in the Tibian Bank before you head out for adventure.'} }
-- if VoiceModule then
    -- npcHandler:addModule(VoiceModule:new(voices))
-- end

local function greetCallback(cid)
    count[cid], transfer[cid] = nil, nil
    return true
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    local player = Player(cid)

    if msgcontains(msg, 'bank account') then
        npcHandler:say({
            'Every Tibian has one. The big advantage is that you can access your money in every branch of the Tibian Bank! ...',
            'Would you like to know more about the {basic} functions of your bank account, the {advanced} functions, or are you already bored, perhaps?'
        }, cid)
        npcHandler.topic[cid] = 0
        return true

	-- Guild Bank System --
    elseif msgcontains(msg, 'guild balance') then
        npcHandler.topic[cid] = 0
        if not player:getGuild() then
            npcHandler:say('You are not a member of a guild.', cid)
            return false
        end
        npcHandler:say('Your guild account balance is ' .. player:getGuild():getBalance() .. ' gold.', cid)
        return true
		-- Guild Bank System --
    elseif msgcontains(msg, 'balance') then
        npcHandler.topic[cid] = 0
        if player:getBankBalance() >= 100000000 then
            npcHandler:say('I think you must be one of the richest inhabitants in the world! Your account balance is ' .. player:getBankBalance() .. ' gold.', cid)
            return true
        elseif player:getBankBalance() >= 10000000 then
            npcHandler:say('You have made ten millions and it still grows! Your account balance is ' .. player:getBankBalance() .. ' gold.', cid)
            return true
        elseif player:getBankBalance() >= 1000000 then
            npcHandler:say('Wow, you have reached the magic number of a million gp!!! Your account balance is ' .. player:getBankBalance() .. ' gold!', cid)
            return true
        elseif player:getBankBalance() >= 100000 then
            npcHandler:say('You certainly have made a pretty penny. Your account balance is ' .. player:getBankBalance() .. ' gold.', cid)
            return true
        else
            npcHandler:say('Your account balance is ' .. player:getBankBalance() .. ' gold.', cid)
            return true
        end
		
	-- Guild Bank System --
    elseif msgcontains(msg, 'guild deposit') then
        if (Player.getExhaustion(player, 494934) > 0) then
            npcHandler:say('You need to wait a time before try deposit.', cid)
            npcHandler.topic[cid] = 0
            return false
        end

        if not player:getGuild() then
            npcHandler:say('You are not a member of a guild.', cid)
            npcHandler.topic[cid] = 0
            return false
        end
        
        if string.match(msg, '%d+') then
            count[cid] = getMoneyCount(msg)
            if count[cid] < 1 then
                npcHandler:say('You do not have enough gold.', cid)
                npcHandler.topic[cid] = 0
                return false
            end
            npcHandler:say('Would you really like to deposit ' .. count[cid] .. ' gold to your {guild account}?', cid)
            npcHandler.topic[cid] = 23
            return true
        else
            npcHandler:say('Please tell me how much gold it is you would like to deposit.', cid)
            npcHandler.topic[cid] = 22
            return true
        end
    elseif npcHandler.topic[cid] == 22 then
        count[cid] = getMoneyCount(msg)
        if isValidMoney(count[cid]) then
            npcHandler:say('Would you really like to deposit ' .. count[cid] .. ' gold to your {guild account}?', cid)
            npcHandler.topic[cid] = 23
            return true
        else
            npcHandler:say('You do not have enough gold.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
    elseif npcHandler.topic[cid] == 23 then
        if msgcontains(msg, 'yes') then
            npcHandler:say('Alright, we have placed an order to deposit the amount of ' .. count[cid] .. ' gold to your guild account. Please check your inbox for confirmation.', cid)
            local guild = player:getGuild()
            local info = {
                type = 'Guild Deposit',
                amount = count[cid],
                owner = player:getName() .. ' of ' .. guild:getName(),
                recipient = player:getName(),
				message = "",
				sucess = false
            }
            local playerBalance = player:getBankBalance()
            if playerBalance < tonumber(count[cid]) then
                info.message = 'We are sorry to inform you that we could not fulfill your request, due to a lack of the required sum on your bank account.'
                info.success = false
            else
                info.message = 'We are happy to inform you that your transfer request was successfully carried out.'
                info.success = true
                guild:setBalance(guild:getBalance() + tonumber(count[cid]))
                player:setBankBalance(playerBalance - tonumber(count[cid]))
                Player.setExhaustion(player, 494934, 2)
                guild:registerAction(player:getId(), tonumber(count[cid]), GUILDBANK_DEPOSIT)
            end

            local inbox = player:getInbox()
            local receipt = gb_getReceipt(info)
            inbox:addItemEx(receipt, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
        elseif msgcontains(msg, 'no') then
            npcHandler:say('As you wish. Is there something else I can do for you?', cid)
        end
		npcHandler.topic[cid] = 0
		return true
		-- Guild Bank System --
	
    elseif msgcontains(msg, 'deposit') then
        if (Player.getExhaustion(player, 494934) > 0) then
            npcHandler:say('You need to wait a time before try deposit.', cid)
            npcHandler.topic[cid] = 0
            return false
        end

        count[cid] = player:getMoney()
        if count[cid] < 1 then
            npcHandler:say('You do not have enough gold.', cid)
            npcHandler.topic[cid] = 0
            return false
        end
        if msgcontains(msg, 'all') then
            count[cid] = player:getMoney()
            npcHandler:say('Would you really like to deposit ' .. count[cid] .. ' gold?', cid)
            npcHandler.topic[cid] = 2
            return true
        else
            if string.match(msg,'%d+') then
                count[cid] = getMoneyCount(msg)
                if count[cid] < 1 then
                    npcHandler:say('You do not have enough gold.', cid)
                    npcHandler.topic[cid] = 0
                    return false
                end
                npcHandler:say('Would you really like to deposit ' .. count[cid] .. ' gold?', cid)
                npcHandler.topic[cid] = 2
                return true
            else
                npcHandler:say('Please tell me how much gold it is you would like to deposit.', cid)
                npcHandler.topic[cid] = 1
                return true
            end
        end
        if not isValidMoney(count[cid]) then
            npcHandler:say('Sorry, but you can\'t deposit that much.', cid)
            npcHandler.topic[cid] = 0
            return false
        end
    elseif npcHandler.topic[cid] == 1 then
        count[cid] = getMoneyCount(msg)
        if isValidMoney(count[cid]) then
            npcHandler:say('Would you really like to deposit ' .. count[cid] .. ' gold?', cid)
            npcHandler.topic[cid] = 2
            return true
        else
            npcHandler:say('You do not have enough gold.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
    elseif npcHandler.topic[cid] == 2 then
        if msgcontains(msg, 'yes') then
            if player:getMoney() + player:getBankBalance() >= tonumber(count[cid]) then
                player:depositMoney(count[cid])
                npcHandler:say('Alright, we have added the amount of ' .. count[cid] .. ' gold to your {balance}. You can {withdraw} your money anytime you want to.', cid)
                Player.setExhaustion(player, 494934, 2)
            else
                npcHandler:say('You do not have enough gold.', cid)
            end
        elseif msgcontains(msg, 'no') then
            npcHandler:say('As you wish. Is there something else I can do for you?', cid)
        end
        npcHandler.topic[cid] = 0
        return true

	-- Guild Bank System --
    elseif msgcontains(msg, 'guild withdraw') then
        if (Player.getExhaustion(player, 494934) > 0) then
            npcHandler:say('You need to wait a time before try withdraw.', cid)
            npcHandler.topic[cid] = 0
            return false
        end

        if not player:getGuild() then
            npcHandler:say('I am sorry but it seems you are currently not in any guild.', cid)
            npcHandler.topic[cid] = 0
            return false
        elseif player:getGuildLevel() < 2 then
            npcHandler:say('Only guild leaders or vice leaders can withdraw money from the guild account.', cid)
            npcHandler.topic[cid] = 0
            return false
        end

        if string.match(msg,'%d+') then
            count[cid] = getMoneyCount(msg)
            if isValidMoney(count[cid]) then
                npcHandler:say('Are you sure you wish to withdraw ' .. count[cid] .. ' gold from your guild account?', cid)
                npcHandler.topic[cid] = 25
            else
                npcHandler:say('There is not enough gold on your guild account.', cid)
                npcHandler.topic[cid] = 0
            end
            return true
        else
            npcHandler:say('Please tell me how much gold you would like to withdraw from your guild account.', cid)
            npcHandler.topic[cid] = 24
            return true
        end
    elseif npcHandler.topic[cid] == 24 then
        count[cid] = getMoneyCount(msg)
        if isValidMoney(count[cid]) then
            npcHandler:say('Are you sure you wish to withdraw ' .. count[cid] .. ' gold from your guild account?', cid)
            npcHandler.topic[cid] = 25
        else
            npcHandler:say('There is not enough gold on your guild account.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
    elseif npcHandler.topic[cid] == 25 then
        if msgcontains(msg, 'yes') then
            local guild = player:getGuild()
            local balance = guild:getBalance()
            npcHandler:say('We placed an order to withdraw ' .. count[cid] .. ' gold from your guild account. Please check your inbox for confirmation.', cid)
            local info = {
                type = 'Guild Withdraw',
                amount = count[cid],
                owner = player:getName() .. ' of ' .. guild:getName(),
                recipient = player:getName(),
				message = "",
				sucess = false
            }
            if balance < tonumber(count[cid]) then
                info.message = 'We are sorry to inform you that we could not fulfill your request, due to a lack of the required sum on your guild account.'
                info.success = false
            else
                info.message = 'We are happy to inform you that your transfer request was successfully carried out.'
                info.success = true
                guild:setBalance(balance - tonumber(count[cid]))
                local playerBalance = player:getBankBalance()
                player:setBankBalance(playerBalance + tonumber(count[cid]))
                Player.setExhaustion(player, 494934, 2)
                guild:registerAction(player:getId(), tonumber(count[cid]), GUILDBANK_WITHDRAW)
            end

            local inbox = player:getInbox()
            local receipt = gb_getReceipt(info)
            inbox:addItemEx(receipt, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
            npcHandler.topic[cid] = 0
        elseif msgcontains(msg, 'no') then
            npcHandler:say('As you wish. Is there something else I can do for you?', cid)
            npcHandler.topic[cid] = 0
        end
        return true
		-- Guild Bank System --
		
    elseif msgcontains(msg, 'withdraw') then
        if (Player.getExhaustion(player, 494934) > 0) then
            npcHandler:say('You need to wait a time before try withdraw.', cid)
            npcHandler.topic[cid] = 0
            return false
        end

        if string.match(msg,'%d+') then
            count[cid] = getMoneyCount(msg)
            if isValidMoney(count[cid]) then
                npcHandler:say('Are you sure you wish to withdraw ' .. count[cid] .. ' gold from your bank account?', cid)
                npcHandler.topic[cid] = 7
            else
                npcHandler:say('There is not enough gold on your account.', cid)
                npcHandler.topic[cid] = 0
            end
            return true
        else
            npcHandler:say('Please tell me how much gold you would like to withdraw.', cid)
            npcHandler.topic[cid] = 6
            return true
        end
    elseif npcHandler.topic[cid] == 6 then
        count[cid] = getMoneyCount(msg)
        if isValidMoney(count[cid]) then
            npcHandler:say('Are you sure you wish to withdraw ' .. count[cid] .. ' gold from your bank account?', cid)
            npcHandler.topic[cid] = 7
        else
            npcHandler:say('There is not enough gold on your account.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
    elseif npcHandler.topic[cid] == 7 then
        if msgcontains(msg, 'yes') then
            if player:getFreeCapacity() >= getMoneyWeight(count[cid]) then
                if not player:withdrawMoney(count[cid]) then
                    npcHandler:say('There is not enough gold on your account.', cid)
                else
                    npcHandler:say('Here you are, ' .. count[cid] .. ' gold. Please let me know if there is something else I can do for you.', cid)
                    Player.setExhaustion(player, 494934, 2)
                end
            else
                npcHandler:say('Whoah, hold on, you have no room in your inventory to carry all those coins. I don\'t want you to drop it on the floor, maybe come back with a cart!', cid)
            end
            npcHandler.topic[cid] = 0
        elseif msgcontains(msg, 'no') then
            npcHandler:say('The customer is king! Come back anytime you want to if you wish to {withdraw} your money.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
		
	-- Guild Bank System --
    elseif msgcontains(msg, 'guild transfer') then
        if (Player.getExhaustion(player, 494934) > 0) then
            npcHandler:say('You need to wait a time before try transfer.', cid)
            npcHandler.topic[cid] = 0
            return false
        end

        if not player:getGuild() then
            npcHandler:say('I am sorry but it seems you are currently not in any guild.', cid)
            npcHandler.topic[cid] = 0
            return false
        elseif player:getGuildLevel() < 2 then
            npcHandler:say('Only guild leaders or vice leaders can transfer money from the guild account.', cid)
            npcHandler.topic[cid] = 0
            return false
        end

        if string.match(msg, '%d+') then
            count[cid] = getMoneyCount(msg)
            if isValidMoney(count[cid]) then
                transfer[cid] = string.match(msg, 'to%s*(.+)$')
                if transfer[cid] then
                    npcHandler:say('So you would like to transfer ' .. count[cid] .. ' gold from your guild account to guild ' .. transfer[cid] .. '?', cid)
                    npcHandler.topic[cid] = 28
                else
                    npcHandler:say('Which guild would you like to transfer ' .. count[cid] .. ' gold to?', cid)
                    npcHandler.topic[cid] = 27
                end
            else
                npcHandler:say('There is not enough gold on your guild account.', cid)
                npcHandler.topic[cid] = 0
            end
        else
            npcHandler:say('Please tell me the amount of gold you would like to transfer.', cid)
            npcHandler.topic[cid] = 26
        end
        return true
    elseif npcHandler.topic[cid] == 26 then
        count[cid] = getMoneyCount(msg)
        if player:getGuild():getBalance() < count[cid] then
            npcHandler:say('There is not enough gold on your guild account.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        if isValidMoney(count[cid]) then
            npcHandler:say('Which guild would you like to transfer ' .. count[cid] .. ' gold to?', cid)
            npcHandler.topic[cid] = 27
        else
            npcHandler:say('There is not enough gold on your account.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
    elseif npcHandler.topic[cid] == 27 then
        transfer[cid] = msg
		local toGuild = getGuildIdByName(transfer[cid])		
        if player:getGuild():getName() == transfer[cid] then
            npcHandler:say('Fill in this field with person who receives your gold!', cid)
            npcHandler.topic[cid] = 0
            return true
		elseif not toGuild then
			npcHandler:say('This guild does not exist on our database!', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        npcHandler:say('So you would like to transfer ' .. count[cid] .. ' gold from your guild account to guild ' .. transfer[cid] .. '?', cid)
        npcHandler.topic[cid] = 28
        return true
    elseif npcHandler.topic[cid] == 28 then
        if msgcontains(msg, 'yes') then
            npcHandler:say('We have placed an order to transfer ' .. count[cid] .. ' gold from your guild account to guild ' .. transfer[cid] .. '. Please check your inbox for confirmation.', cid)
            local fromGuild = player:getGuild()
            local fromGuildBalance = fromGuild:getBalance()
            local info = {
                type = 'Guild to Guild Transfer',
                amount = count[cid],
                owner = player:getName() .. ' of ' .. fromGuild:getName(),
                recipient = transfer[cid],
				message = "",
				success = false
            }
            if fromGuildBalance < tonumber(count[cid]) then
                info.message = 'We are sorry to inform you that we could not fulfill your request, due to a lack of the required sum on your guild account.'
                info.success = false
                local inbox = player:getInbox()
                local receipt = gb_getReceipt(info)
                inbox:addItemEx(receipt, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
            else
				local toGuild_ = getGuildIdByName(transfer[cid])
				fromGuild:transferToGuild(player:getId(), tonumber(count[cid]), toGuild_, info)
                Player.setExhaustion(player, 494934, 2)
            end
            npcHandler.topic[cid] = 0
        elseif msgcontains(msg, 'no') then
            npcHandler:say('Alright, is there something else I can do for you?', cid)
        end
        npcHandler.topic[cid] = 0
		-- Guild Bank System --

    elseif msgcontains(msg, 'transfer') then
        if (Player.getExhaustion(player, 494934) > 0) then
            npcHandler:say('You need to wait a time before try transfer.', cid)
            npcHandler.topic[cid] = 0
            return false
        end

        npcHandler:say('Please tell me the amount of gold you would like to transfer.', cid)
        npcHandler.topic[cid] = 11
    elseif npcHandler.topic[cid] == 11 then
        count[cid] = getMoneyCount(msg)
        if player:getBankBalance() < count[cid] then
            npcHandler:say('There is not enough gold on your account.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        if isValidMoney(count[cid]) then
            npcHandler:say('Who would you like transfer ' .. count[cid] .. ' gold to?', cid)
            npcHandler.topic[cid] = 12
        else
            npcHandler:say('There is not enough gold on your account.', cid)
            npcHandler.topic[cid] = 0
        end
    elseif npcHandler.topic[cid] == 12 then
        transfer[cid] = msg
        if player:getName() == transfer[cid] then
            npcHandler:say('Fill in this field with person who receives your gold!', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        if playerExists(transfer[cid]) then
           local arrayDenied = {"accountmanager", "rooksample", "druidsample", "sorcerersample", "knightsample", "paladinsample"}
		    if isInArray(arrayDenied, string.gsub(transfer[cid]:lower(), " ", "")) then
                npcHandler:say('This player does not exist.', cid)
                npcHandler.topic[cid] = 0
                return true
            end
            npcHandler:say('So you would like to transfer ' .. count[cid] .. ' gold to ' .. transfer[cid] .. '?', cid)
            npcHandler.topic[cid] = 13
        else
            npcHandler:say('This player does not exist.', cid)
            npcHandler.topic[cid] = 0
        end
    elseif npcHandler.topic[cid] == 13 then
        if msgcontains(msg, 'yes') then
            if not player:transferMoneyTo(transfer[cid], count[cid]) then
                npcHandler:say('You cannot transfer money to this account.', cid)
            else
                npcHandler:say('Very well. You have transferred ' .. count[cid] .. ' gold to ' .. transfer[cid] ..'.', cid)
                Player.setExhaustion(player, 494934, 2)
                transfer[cid] = nil
            end
        elseif msgcontains(msg, 'no') then
            npcHandler:say('Alright, is there something else I can do for you?', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'change gold') then
        npcHandler:say('How many platinum coins would you like to get?', cid)
        npcHandler.topic[cid] = 14
    elseif npcHandler.topic[cid] == 14 then
        if getMoneyCount(msg) < 1 then
            npcHandler:say('Sorry, you do not have enough gold coins.', cid)
            npcHandler.topic[cid] = 0
        else
            count[cid] = getMoneyCount(msg)
            npcHandler:say('So you would like me to change ' .. count[cid] * 100 .. ' of your gold coins into ' .. count[cid] .. ' platinum coins?', cid)
            npcHandler.topic[cid] = 15
        end
    elseif npcHandler.topic[cid] == 15 then
        if msgcontains(msg, 'yes') then
            if player:removeItem(2148, count[cid] * 100) then
                player:addItem(2152, count[cid])
                npcHandler:say('Here you are.', cid)
            else
                npcHandler:say('Sorry, you do not have enough gold coins.', cid)
            end
        else
            npcHandler:say('Well, can I help you with something else?', cid)
        end
        npcHandler.topic[cid] = 0
    elseif msgcontains(msg, 'change platinum') then
        npcHandler:say('Would you like to change your platinum coins into gold or crystal?', cid)
        npcHandler.topic[cid] = 16
    elseif npcHandler.topic[cid] == 16 then
        if msgcontains(msg, 'gold') then
            npcHandler:say('How many platinum coins would you like to change into gold?', cid)
            npcHandler.topic[cid] = 17
        elseif msgcontains(msg, 'crystal') then
            npcHandler:say('How many crystal coins would you like to get?', cid)
            npcHandler.topic[cid] = 19
        else
            npcHandler:say('Well, can I help you with something else?', cid)
            npcHandler.topic[cid] = 0
        end
    elseif npcHandler.topic[cid] == 17 then
        if getMoneyCount(msg) < 1 then
            npcHandler:say('Sorry, you do not have enough platinum coins.', cid)
            npcHandler.topic[cid] = 0
        else
            count[cid] = getMoneyCount(msg)
            npcHandler:say('So you would like me to change ' .. count[cid] .. ' of your platinum coins into ' .. count[cid] * 100 .. ' gold coins for you?', cid)
            npcHandler.topic[cid] = 18
        end
    elseif npcHandler.topic[cid] == 18 then
        if msgcontains(msg, 'yes') then
            if player:removeItem(2152, count[cid]) then
                player:addItem(2148, count[cid] * 100)
                npcHandler:say('Here you are.', cid)
            else
                npcHandler:say('Sorry, you do not have enough platinum coins.', cid)
            end
        else
            npcHandler:say('Well, can I help you with something else?', cid)
        end
        npcHandler.topic[cid] = 0
    elseif npcHandler.topic[cid] == 19 then
        if getMoneyCount(msg) < 1 then
            npcHandler:say('Sorry, you do not have enough platinum coins.', cid)
            npcHandler.topic[cid] = 0
        else
            count[cid] = getMoneyCount(msg)
            npcHandler:say('So you would like me to change ' .. count[cid] * 100 .. ' of your platinum coins into ' .. count[cid] .. ' crystal coins for you?', cid)
            npcHandler.topic[cid] = 20
        end
    elseif npcHandler.topic[cid] == 20 then
        if msgcontains(msg, 'yes') then
            if player:removeItem(2152, count[cid] * 100) then
                player:addItem(2160, count[cid])
                npcHandler:say('Here you are.', cid)
            else
                npcHandler:say('Sorry, you do not have enough platinum coins.', cid)
            end
        else
            npcHandler:say('Well, can I help you with something else?', cid)
        end
        npcHandler.topic[cid] = 0

    elseif msgcontains(msg, 'change crystal') then
        npcHandler:say('How many crystal coins would you like to change into platinum?', cid)
        npcHandler.topic[cid] = 21
    elseif npcHandler.topic[cid] == 21 then
        if getMoneyCount(msg) < 1 then
            npcHandler:say('Sorry, you do not have enough crystal coins.', cid)
            npcHandler.topic[cid] = 0
        else
            count[cid] = getMoneyCount(msg)
            npcHandler:say('So you would like me to change ' .. count[cid] .. ' of your crystal coins into ' .. count[cid] * 100 .. ' platinum coins for you?', cid)
            npcHandler.topic[cid] = 22
        end
    elseif npcHandler.topic[cid] == 22 then
        if msgcontains(msg, 'yes') then
            if player:removeItem(2160, count[cid])  then
                player:addItem(2152, count[cid] * 100)
                npcHandler:say('Here you are.', cid)
            else
                npcHandler:say('Sorry, you do not have enough crystal coins.', cid)
            end
        else
            npcHandler:say('Well, can I help you with something else?', cid)
        end
        npcHandler.topic[cid] = 0
    end
    return true
end

keywordHandler:addKeyword({'money'}, StdModule.say, {npcHandler = npcHandler, text = 'We can {change} money for you. You can also access your {bank account}.'})
keywordHandler:addKeyword({'change'}, StdModule.say, {npcHandler = npcHandler, text = 'There are three different coin types in Tibia: 100 gold coins equal 1 platinum coin, 100 platinum coins equal 1 crystal coin. So if you\'d like to change 100 gold into 1 platinum, simply say \'{change gold}\' and then \'1 platinum\'.'})
keywordHandler:addKeyword({'bank'}, StdModule.say, {npcHandler = npcHandler, text = 'We can {change} money for you. You can also access your {bank account}.'})
keywordHandler:addKeyword({'advanced'}, StdModule.say, {npcHandler = npcHandler, text = 'Your bank account will be used automatically when you want to {rent} a house or place an offer on an item on the {market}. Let me know if you want to know about how either one works.'})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation.'})
keywordHandler:addKeyword({'functions'}, StdModule.say, {npcHandler = npcHandler, text = 'You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation.'})
keywordHandler:addKeyword({'basic'}, StdModule.say, {npcHandler = npcHandler, text = 'You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I work in this bank. I can change money for you and help you with your bank account.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "My name is Naji. My mother gave me that name because she knew a Paladin with that name. I'm a spare timer hunter by myself, you know! I want to join the {Paw and Fur - hunting elite}!"})
keywordHandler:addKeyword({'paw and fur'}, StdModule.say, {npcHandler = npcHandler, text = "The Paw and Fur - Hunting Elite is a newly founded hunting society in Port Hope. It is said that they send you on hunting mission. Sounds great if you ask me."})

npcHandler:setMessage(MESSAGE_GREET, "Yes? What may I do for you, |PLAYERNAME|? Bank business, perhaps?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Have a nice day.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Have a nice day.")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
