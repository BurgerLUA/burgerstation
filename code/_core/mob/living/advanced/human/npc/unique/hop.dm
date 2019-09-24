/mob/living/advanced/npc/unique/hop
	name = "Head of Personnel"
	desc = "All access, please."
	mob_species = /species/human/
	sex = FEMALE
	gender = FEMALE
	dialogue_id = "hop_dialogue"
	dir = WEST


/mob/living/advanced/npc/unique/hop/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#B48E7A")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon = 'icons/mob/living/advanced/hair/head.dmi', desired_icon_state = "hair_long")
	update_all_blends()
	add_outfit("hop_outfit")
	return .