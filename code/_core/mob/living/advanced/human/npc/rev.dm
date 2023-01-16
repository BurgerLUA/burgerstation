/mob/living/advanced/npc/rev
	name = "revolutionary soldier"
	desc = "FOR THE REVOLUTION!"
	desc_extended = "An ex-nanotrasen revolutionary soldier fighting for their right to \[EXPUNGED\]. Surprisingly, they're not syndicate backed."
	ai = /ai/advanced/slavic

	combat_dialogue = /combat_dialogue/revolutionary

	var/list/possible_outfits = list(
		/loadout/slavic/infantry = 100,
		/loadout/slavic/sniper = 10,

	)

	var/loadout_to_level = list(
		/loadout/slavic/infantry = 1,
		/loadout/slavic/sniper = 1.2,
	)

	dna = /dna/human

	soul_size = SOUL_SIZE_COMMON

	level = 22

/mob/living/advanced/npc/rev/Initialize()
	loadout = pickweight(possible_outfits)
	level *= loadout_to_level[loadout]
	. = ..()

/mob/living/advanced/npc/rev/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/revolutionary)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/revolutionary)


/mob/living/advanced/npc/rev/elite
	name = "elite revolutionary soldier"

	possible_outfits = list(
		/loadout/slavic/infantry/advanced = 100,
		/loadout/slavic/sniper/advanced = 10,

	)

	loadout_to_level = list(
		/loadout/slavic/infantry/advanced = 1,
		/loadout/slavic/sniper/advanced = 1.2,
	)