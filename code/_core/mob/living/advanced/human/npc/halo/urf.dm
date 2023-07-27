/mob/living/advanced/npc/urf
	name = "\improper URF Insurrectionist"
	desc = "A security team that actually follows orders!"
	desc_extended = "A low-ranking URF soldier tasked with assisting with higher ranking URF personnel with missions."

	dialogue_id = /dialogue/npc/soldier/
	//loadout = /loadout/urf/urf_soldier
	ai = /ai/advanced/syndicate

	dna = /dna/human
	level = 8

	var/list/possible_outfits = list(
		/loadout/urf/urf_soldier = 70,
		/loadout/urf/urf_marksmen = 20,
		/loadout/urf/urf_pointmen = 10

	)

	var/loadout_to_level = list(
		/loadout/urf/urf_soldier = 1,
		/loadout/urf/urf_marksmen = 1.25,
		/loadout/urf/urf_pointmen = 1.25
	)

/mob/living/advanced/npc/urf/Initialize()
	loadout = pickweight(possible_outfits)
	level *= loadout_to_level[loadout]
	. = ..()


/mob/living/advanced/npc/urf/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)

/mob/living/advanced/npc/urf/lobby
	var/active = TRUE