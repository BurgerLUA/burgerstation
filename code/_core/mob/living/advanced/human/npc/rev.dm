/mob/living/advanced/npc/rev
	name = "revolutionary soldier"
	desc = "FOR THE REVOLUTION!"
	desc_extended = "An ex-nanotrasen revolutionary soldier fighting for their right to \[EXPUNGED\]. Surprisingly, they're not syndicate backed."
	ai = /ai/advanced/slavic

	var/list/possible_outfits = list(
		/loadout/rev/solider = 10,
		/loadout/rev/solider/alt = 10,
		/loadout/rev/skat = 10,
		/loadout/rev/exo = 5,
		/loadout/rev/sniper = 5
	)

	var/loadout_to_level = list(
		/loadout/rev/solider = 1,
		/loadout/rev/solider/alt = 2,
		/loadout/rev/skat = 4,
		/loadout/rev/exo = 8,
		/loadout/rev/sniper = 8
	)

	dna = /dna/human

	level = 22

/mob/living/advanced/npc/rev/Initialize()
	loadout = pickweight(possible_outfits)
	level *= loadout_to_level[loadout]
	. = ..()

/mob/living/advanced/npc/rev/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/revolutionary)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/revolutionary)

