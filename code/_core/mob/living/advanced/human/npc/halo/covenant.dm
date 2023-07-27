/mob/living/advanced/npc/unggoy
	name = "\improper Grunt"
	desc = "Little people first!"
	desc_extended = "Short cowardly little creature..."
	species = "unga"
	dialogue_id = /dialogue/npc/soldier/
	//loadout = /loadout/unsc/marine/marine_rifleman
	ai = /ai/advanced/halo/unggoy
	blood_type = /reagent/blood/unggoy
	level = 8

	var/list/possible_outfits = list(
		/loadout/covenant/unggoy_minor = 70,
		/loadout/covenant/unggoy_major = 20,
		/loadout/covenant/unggoy_ultra = 10
	)

	var/loadout_to_level = list(
		/loadout/covenant/unggoy_minor = 1,
		/loadout/covenant/unggoy_major = 1.25,
		/loadout/covenant/unggoy_ultra = 1.25
	)

/mob/living/advanced/npc/unggoy/Initialize()
	loadout = pickweight(possible_outfits)
	level *= loadout_to_level[loadout]
	. = ..()


/mob/living/advanced/npc/unggoy/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)

/mob/living/advanced/npc/kigyar
	name = "\improper Jackal"
	desc = "Bird man."
	desc_extended = "Shoots better than the little ones..."
	species = "Kigyar"
	dialogue_id = /dialogue/npc/soldier/
	//loadout = /loadout/unsc/marine/marine_rifleman
	ai = /ai/advanced/halo/kigyar
	blood_type = /reagent/blood/kigyar
	level = 8

	var/list/possible_outfits = list(
		/loadout/covenant/kigyar = 70,
		/loadout/covenant/kigyar_ranged = 20,
		/loadout/covenant/kigyar_needler = 10
	)

	var/loadout_to_level = list(
		/loadout/covenant/kigyar = 1,
		/loadout/covenant/kigyar_ranged = 1.25,
		/loadout/covenant/kigyar_needler = 1.25
	)

/mob/living/advanced/npc/kigyar/Initialize()
	loadout = pickweight(possible_outfits)
	level *= loadout_to_level[loadout]
	. = ..()


/mob/living/advanced/npc/kigyar/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)

/mob/living/advanced/npc/unggoy/lobby
	var/active = TRUE

/mob/living/advanced/npc/kigyar/lobby
	var/active = TRUE