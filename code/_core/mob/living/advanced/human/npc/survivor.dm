/mob/living/advanced/npc/survivor
	name = "bandit"
	desc = "Get off my lawn!"

	dna = /dna/human

	soul_size = SOUL_SIZE_COMMON

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


/mob/living/advanced/npc/survivor/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/space_cop)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/space_cop)