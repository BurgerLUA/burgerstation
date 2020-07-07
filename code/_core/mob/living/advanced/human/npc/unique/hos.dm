/mob/living/advanced/npc/unique/hos
	name = "Head of Security"
	desc = "Shitsec Prime."
	species = "human"
	sex = MALE
	gender = MALE
	dialogue_id = "hos_dialogue"
	dir = SOUTH


/mob/living/advanced/npc/unique/hos/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#8E675C")
	change_organ_visual("hair_head", desired_color = "#6E543C", desired_icon_state = "hair_topknot_s")
	update_all_blends()
	equip_loadout(/loadout/hos)
	return .