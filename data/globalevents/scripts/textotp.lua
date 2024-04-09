local effects = {



	{position = Position(162, 49, 7), text = 'Trainers', effect = CONST_ME_CRITICAL_DAMAGE},
	{position = Position(164, 49, 7), text = 'Events Room', effect = CONST_ME_PINK_BEAM},
	{position = Position(158, 49, 7), text = 'Innitial Hunt', effect = CONST_ME_PINK_VORTEX},
	{position = Position(157, 49, 7), text = 'NPCs', effect = CONST_ME_TUTORIALSQUARE},

	
}

function onThink(interval)
    for i = 1, #effects do
        local settings = effects[i]
        local spectators = Game.getSpectators(settings.position, false, true, 7, 7, 5, 5)
        if #spectators > 0 then
            if settings.text then
                for i = 1, #spectators do
                    spectators[i]:say(settings.text, TALKTYPE_MONSTER_SAY, false, spectators[i], settings.position)
                end
            end
            if settings.effect then
                settings.position:sendMagicEffect(settings.effect)
            end
        end
    end
   return true
end
 