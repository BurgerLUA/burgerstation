/mob/living/advanced/npc/abductor
	name = "abductor"
	desc = "Ayy lmao. The most annoying thing in the known universe."
	ai = /ai/advanced/abductor

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

	level = 10

	species = "abductor"

	sex = NEUTER
	gender = NEUTER

	loyalty_tag = "Abductor"
	iff_tag = "Abductor"

	var/loadout/loadout_to_use

/mob/living/advanced/npc/abductor/Initialize()
	loadout_to_use = pickweight(possible_outfits)
	level *= loadout_to_level[loadout_to_use]
	. = ..()


/mob/living/advanced/npc/abductor/Finalize()
	. = ..()
	if(loadout_to_use) equip_loadout(loadout_to_use)


