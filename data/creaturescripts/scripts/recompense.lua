function onAdvance(cid, skill, oldlevel, newlevel)

	       	if getPlayerLevel(cid) >= 8 and getPlayerStorageValue(cid, 99963) ~= 1 then
						    doPlayerSetBalance(cid, getPlayerBalance(cid) + 2000)
						    setPlayerStorageValue(cid, 99963, 1)
						    doPlayerSendTextMessage(cid, 19, "You have received 2000 gold in your bank for advancing to Level 8.")

		    elseif getPlayerLevel(cid) >= 20 and getPlayerStorageValue(cid, 99964) ~= 1 then
						    doPlayerSetBalance(cid, getPlayerBalance(cid) + 30000)
						    setPlayerStorageValue(cid, 99964, 1)
						    doPlayerSendTextMessage(cid, 19, "You have received 30000 gold in your bank for advancing to Level 20.")


		     elseif getPlayerLevel(cid) >= 30 and getPlayerStorageValue(cid, 99966) ~= 1 then
						    doPlayerSetBalance(cid, getPlayerBalance(cid) + 40000)
						    setPlayerStorageValue(cid, 99966, 1)
						    doPlayerSendTextMessage(cid, 19, "You have received 40000 gold in your bank for advancing to Level 30.")
				
							
			elseif getPlayerLevel(cid) >= 40 and getPlayerStorageValue(cid, 99969) ~= 1 then
						    doPlayerSetBalance(cid, getPlayerBalance(cid) + 50000)
						    setPlayerStorageValue(cid, 99969, 1)
						   doPlayerSendTextMessage(cid, 19, "You have received 50000 gold in your bank for advancing to Level 40.")
											
			
            elseif getPlayerLevel(cid) >= 50 and getPlayerStorageValue(cid, 99970) ~= 1 then
						    doPlayerAddItem(cid, 5942)
						    setPlayerStorageValue(cid, 99970, 1)
						    doPlayerSendTextMessage(cid, 19, "You have received one blessed wooden stake because you reached level 50.")
			

												
						    end
		    return TRUE
end
