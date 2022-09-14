/mob/living/advanced/npc/deathsquad
	name = "deathsquad commando"
	desc = "An elite member of the Deathsquad. They are tasked to leave no witnesses."
	ai = /ai/advanced/syndicate

	dialogue_id = /dialogue/npc/soldier

	loadout = /loadout/deathsquad

	level = 80

/mob/living/advanced/npc/deathsquad/Generate()
	sex = pick(MALE,FEMALE)
	gender = prob(1) ? pick(MALE,FEMALE) : sex
	. = ..()

/mob/living/advanced/npc/deathsquad/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/deathsquad)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/deathsquad)

/mob/living/advanced/npc/deathsquad/light
	loadout = /loadout/deathsquad/light


/mob/living/advanced/npc/deathsquad/medium
	loadout = /loadout/deathsquad/medium


/mob/living/advanced/npc/deathsquad/heavy
	loadout = /loadout/deathsquad/heavy
