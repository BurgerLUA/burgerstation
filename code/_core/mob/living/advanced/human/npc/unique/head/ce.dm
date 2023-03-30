/mob/living/advanced/npc/unique/head/ce
	name = "Chief Engineer"
	desc = "Doesn't have to worry about plasmafloods here."
	species = "human"
	dialogue_id = /dialogue/npc/hop/
	sex = FEMALE
	gender = FEMALE

	dna = /dna/human

	anchored = TRUE
	health = null

	level = 50

	loadout = /loadout/nanotrasen/head/ce

/mob/living/advanced/npc/unique/head/ce/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#967864")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon_state = "hair_shorthairg")