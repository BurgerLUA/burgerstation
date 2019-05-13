var/global/list/spellcraft/buff/all_buffs = list()
var/global/list/spellcraft/buff/all_effects = list()
var/global/list/spellcraft/buff/all_modifers = list()

/subsystem/spellcrafing/
	name = "Spellcrafting Subsystem"
	desc = "Stores all the known spellcrafting subystems in a list."
	priority = SS_ORDER_NORMAL

/subsystem/skills/Initialize()

	for(var/A in subtypesof(/spellcraft/buff/))
		var/spellcraft/buff/S = new A
		if(!S.id)
			qdel(S)
			continue
		all_buffs[S.id] = S

	for(var/A in subtypesof(/spellcraft/effect/))
		var/spellcraft/effect/S = new A
		if(!S.id)
			qdel(S)
			continue
		all_buffs[S.id] = S

	for(var/A in subtypesof(/spellcraft/modifier/))
		var/spellcraft/modifier/S = new A
		if(!S.id)
			qdel(S)
			continue
		all_buffs[S.id] = S