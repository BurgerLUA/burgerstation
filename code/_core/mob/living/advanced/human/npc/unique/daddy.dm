/mob/living/advanced/npc/unique/daddy
	name = "\improper the legend"
	ai = /ai/advanced/daddy

	health_base = 2000

	level = 14

	soul_size = SOUL_SIZE_RARE

	loadout = /loadout/daddy
	dna = /dna/human

	status_immune = list(
		DISARM = TRUE,
		GRAB = TRUE,
	)

/mob/living/advanced/npc/unique/daddy/setup_name()
	name = "\improper THE LEGEND (SL 99)"
	return TRUE