/mob/living/advanced/npc/cultist
	name = "cultist"
	desc = "*incomprehensible gibberish*"
	desc_extended = "A cultist of Nar'sie."
	ai = /ai/advanced/cult


	loadout = /loadout/cultist

	health_base = 100
	mana_base = 100
	stamina_base = 100

	level = 12

/mob/living/advanced/npc/cultist/Generate()
	sex = pick(MALE,FEMALE)
	gender = prob(1) ? pick(MALE,FEMALE) : sex
	. = ..()

/mob/living/advanced/npc/cultist/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/cult)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/cult)

/mob/living/advanced/npc/cultist/old
	name = "ancient cultist"
	loadout = /loadout/cultist/old

	level = 60


/mob/living/advanced/npc/cultist/hard
	name = "master cultist"
	loadout = /loadout/cultist/hard

	level = 90
