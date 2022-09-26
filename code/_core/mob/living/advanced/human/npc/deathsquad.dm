/mob/living/advanced/npc/deathsquad
	name = "deathsquad commando"
	desc = "An elite member of NanoTrasen's Deathsquad division. They are tasked to leave no witnesses and aren't supposed to actually exist."
	ai = /ai/advanced/syndicate

	dna = /dna/human

	dialogue_id = /dialogue/npc/soldier

	loadout = /loadout/deathsquad

	level = 80

/mob/living/advanced/npc/deathsquad/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/deathsquad)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/deathsquad)