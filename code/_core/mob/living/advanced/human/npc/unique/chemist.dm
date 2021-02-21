/mob/living/advanced/npc/unique/chemist
	name = "Walt Black"
	sex = MALE
	gender = MALE
	dialogue_id = "chemist_dialogue"
	dir = WEST

/mob/living/advanced/npc/unique/chemist/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#EFC9BD")
	change_organ_visual("hair_head", desired_color = "#FFFFFF", desired_icon_state = "none")
	update_all_blends()
	equip_loadout(/loadout/chemist/)
	