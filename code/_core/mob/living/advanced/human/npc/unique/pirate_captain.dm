/mob/living/advanced/npc/unique/pirate_captain
	name = "Captain Condom"
	desc = "The one and only."
	species = "skeleton"
	sex = MALE
	gender = MALE

/mob/living/advanced/npc/unique/pirate_captain/Initialize()
	. = ..()
	equip_loadout(/loadout/pirate_captain)
	return .

/mob/living/advanced/npc/pirate_crew
	name = "skeleton crew"
	desc = "RATTLE ME BONES."
	species = "skeleton"
	sex = MALE
	gender = MALE

/mob/living/advanced/npc/pirate_crew/Initialize()
	. = ..()
	equip_loadout(/loadout/pirate_crew)
	return .
