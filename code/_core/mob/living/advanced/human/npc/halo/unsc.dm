/mob/living/advanced/npc/unsc
	name = "\improper UNSC Marine"
	desc = "A security team that actually follows orders!"
	desc_extended = "A low-ranking UNSC Marine tasked with assisting with higher ranking UNSC personnel with missions."

	dialogue_id = /dialogue/npc/soldier/
	//loadout = /loadout/unsc/marine/marine_rifleman
	ai = /ai/advanced/nanotrasen

	dna = /dna/human
	level = 8

	var/list/possible_outfits = list(
		/loadout/unsc/marine/marine_rifleman = 70,
		/loadout/unsc/marine/marine_marksman = 20,
		/loadout/unsc/marine/marine_machinegunner = 10,
	)

	var/loadout_to_level = list(
		/loadout/unsc/marine/marine_rifleman = 1,
		/loadout/unsc/marine/marine_marksman = 1.25,
		/loadout/unsc/marine/marine_machinegunner = 1.25,
	)

/mob/living/advanced/npc/unsc/Initialize()
	loadout = pickweight(possible_outfits)
	level *= loadout_to_level[loadout]
	. = ..()


/mob/living/advanced/npc/unsc/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

/mob/living/advanced/npc/unsc/lobby
	var/active = TRUE