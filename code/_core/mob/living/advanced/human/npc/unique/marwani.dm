/mob/living/advanced/human/npc/unique/marwani
	name = "Ilaeza Marwani"
	desc = "Fucking liggers."
	mob_species = /species/reptile_advanced/
	gender = FEMALE

/mob/living/advanced/human/npc/unique/marwani/Initialize()
	..()
	change_organ_visual("skin", desired_color = "#8CA73E")
	change_organ_visual("hair_head", desired_color = "#fff0be", desired_icon_state = "unathi_frills")
	add_outfit("marwani_outfit")

/mob/living/advanced/human/npc/unique/marwani/ship
	dialogue_id = "marwani_tutorial_dialogue"