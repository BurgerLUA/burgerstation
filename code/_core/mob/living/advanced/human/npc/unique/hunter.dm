/mob/living/advanced/npc/unique/hunter
	name = "Bar-Shaleez"
	desc = "Fucking liggers."
	mob_species = /species/reptile_advanced/
	sex = FEMALE
	gender = FEMALE
	//dialogue_id = "marwani_dialogue"
	dir = EAST

/mob/living/advanced/npc/unique/hunter/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#779922")
	change_organ_visual("hair_head", desired_color = "#779922", desired_icon = 'icons/mob/living/advanced/hair/unathi.dmi', desired_icon_state = "frills_short")
	update_all_blends()
	add_outfit("hunter_outfit")
	return .