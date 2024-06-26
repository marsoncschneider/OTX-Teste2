local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

function onGetFormulaValues(player, skill, attack, factor, tool)
	local element = 0
	if tool then
		local it = ItemType(tool:getId())
		if it and it:getElementDamage() and it:getElementType() ~= COMBAT_NONE then
			element = it:getElementDamage()
		end
	end

	local skillTotal = skill * attack
	local levelTotal = player:getLevel() / 5
	local min, max = player:getSpellDamage(-(((skillTotal * 0.10) + 7) + (levelTotal)), -(((skillTotal * 0.12) + 11) + (levelTotal)))

	local skillSecond = skill * element
	local minb, maxb = 0, 0
	if skillSecond > 0 then
		minb, maxb = player:getSpellDamage(-(((skillSecond * 0.10) + 7) + (levelTotal)), -(((skillSecond * 0.12) + 11) + (levelTotal)))
	end

	return min, max, minb, maxb
end
combat:setCallback(CALLBACK_PARAM_SKILLVALUE_EXTENDED, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
