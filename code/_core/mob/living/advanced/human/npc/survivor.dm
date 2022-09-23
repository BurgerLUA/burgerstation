/mob/living/advanced/npc/survivor
	name = "hostile survivor"
	desc = "Get off my lawn!"

	dna = /dna/human

	ai = /ai/advanced/suvivor

	level = 40

/mob/living/advanced/npc/survivor/setup_appearance(var/set_default=FALSE)

	. = ..()

	if(prob(10))
		if(gender == FEMALE)
			loadout = /loadout/survivor/female/melee
		else
			loadout = /loadout/survivor/male/melee

	else
		if(gender == FEMALE)
			loadout = /loadout/survivor/female
		else
			loadout = /loadout/survivor/male