/mob/living/advanced/npc/unique/marwani
	name = "Ilaeza Marwani"
	species = "reptile_advanced"
	sex = FEMALE
	gender = FEMALE
	dialogue_id = "marwani_dialogue"
	ai = /ai/villager

/mob/living/advanced/npc/unique/marwani/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#8CA73E")
	change_organ_visual("hair_head", desired_color = "#fff0be", desired_icon_state = "frills")
	update_all_blends()
	add_outfit("marwani_outfit")
	return .

/mob/living/advanced/npc/unique/marwani/ship
	dialogue_id = "marwani_tutorial_dialogue"
	ai = null