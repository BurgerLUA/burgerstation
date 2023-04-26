/mob/living/advanced/npc/unique/head/hos
	name = "Head of Security"
	desc = "No clowns allowed."
	species = "human"
	dialogue_id = /dialogue/npc/head_of_security/
	sex = FEMALE
	gender = FEMALE

	dna = /dna/human

	anchored = TRUE
	health = null

	level = 50

	loadout = /loadout/nanotrasen/head/hos

/mob/living/advanced/npc/unique/head/hos/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#B48E7A")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon_state = "hair_long")