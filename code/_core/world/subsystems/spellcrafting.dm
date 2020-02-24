var/global/list/spellcraft/buff/all_buffs = list()
var/global/list/spellcraft/buff/all_effects = list()
var/global/list/spellcraft/buff/all_modifiers = list()

SUBSYSTEM_DEF(spellcrafing)
	name = "Spellcrafting Subsystem"
	desc = "Stores all the known spellcrafting subystems in a list."
	priority = SS_ORDER_PRELOAD

/subsystem/spellcrafing/Initialize()

	for(var/A in typesof(/spellcraft/effect/))
		var/spellcraft/effect/S = new A
		if(!S.id)
			qdel(S)
			continue
		all_effects[S.id] = S

	LOG_SERVER("Initialized [length(all_effects)] spell effects.")

	for(var/A in typesof(/spellcraft/modifier/))
		var/spellcraft/modifier/S = new A
		if(!S.id)
			qdel(S)
			continue
		all_modifiers[S.id] = S

	LOG_SERVER("Initialized [length(all_modifiers)] spell modifiers.")


	for(var/A in typesof(/spellcraft/buff/))
		var/spellcraft/buff/S = new A
		if(!S.id)
			qdel(S)
			continue
		all_buffs[S.id] = S

	LOG_SERVER("Initialized [length(all_buffs)] spell buffs.")




