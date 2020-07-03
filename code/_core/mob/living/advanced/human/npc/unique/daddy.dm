/mob/living/advanced/npc/unique/daddy
	name = "\improper the legend"
	enable_AI = TRUE
	ai = /ai/advanced/daddy
	class = /class/daddy/


/mob/living/advanced/npc/unique/setup_name()
	name = "\improper THE LEGEND (SL 99)"
	return TRUE

/mob/living/advanced/npc/unique/Initialize()

	. = ..()

	equip_loadout(/loadout/daddy)

	return .