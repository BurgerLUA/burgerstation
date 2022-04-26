/mob/living/advanced/npc/abductor
	name = "abductor"
	desc = "Ayy lmao."
	ai = /ai/advanced

	var/list/possible_outfits = list(
		/loadout/abductor = 40,
		/loadout/abductor/tourist = 1,
		/loadout/abductor/scientist = 80,
		/loadout/abductor/soldier = 80
	)

	var/loadout_to_level = list(
		/loadout/abductor = 1,
		/loadout/abductor/tourist = 1,
		/loadout/abductor/scientist = 2,
		/loadout/abductor/soldier = 4
	)

	level = 20

	species = "abductor"

	sex = NEUTER
	gender = NEUTER

	loyalty_tag = "Abductor"
	iff_tag = "Abductor"

/mob/living/advanced/npc/abductor/Initialize()

	var/loadout_to_use = pickweight(possible_outfits)
	level *= loadout_to_level[loadout_to_use]

	. = ..()

	update_all_blends()

	equip_loadout(loadout_to_use)