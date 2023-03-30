/mob/living/advanced/npc/unique/head/hop
	name = "Head of Personnel"
	desc = "All access, please."
	species = "human"
	dialogue_id = /dialogue/npc/hop/
	sex = FEMALE
	gender = FEMALE

	dna = /dna/human

	anchored = TRUE
	health = null

	level = 50

	loadout = /loadout/nanotrasen/head/hop

/mob/living/advanced/npc/unique/head/hop/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#B48E7A")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon_state = "hair_long")