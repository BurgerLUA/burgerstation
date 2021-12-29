/mob/living/advanced/npc/unique/daddy
	name = "\improper the legend"
	enable_AI = TRUE
	ai = /ai/advanced/daddy


	health_base = 2000

	level = 14

/mob/living/advanced/npc/unique/daddy/setup_name()
	name = "\improper THE LEGEND (SL 99)"
	return TRUE

/mob/living/advanced/npc/unique/daddy/Initialize()

	. = ..()

	equip_loadout(/loadout/daddy)

