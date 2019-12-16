/mob/living/advanced/npc/unique/bar_shaleez
	name = "Bar-Shaleez"
	species = "reptile_advanced"
	sex = FEMALE
	gender = FEMALE
	//dialogue_id = "marwani_dialogue"
	dir = EAST

/mob/living/advanced/npc/unique/bar_shaleez/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#779922")
	change_organ_visual("hair_head", desired_color = "#779922", desired_icon_state = "frills_short")
	update_all_blends()
	add_outfit("hunter_outfit")
	return .