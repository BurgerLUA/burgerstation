/mob/living/advanced/npc/survivor
	name = "hostile survivor"
	desc = "Get off my lawn!"

	ai = /ai/advanced/suvivor

	level = 40

/mob/living/advanced/npc/survivor/Initialize()

	sex = pick(MALE,FEMALE)
	gender = prob(1) ? pick(MALE,FEMALE) : sex

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

	. = ..()
