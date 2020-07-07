/mob/living/advanced/npc/unique/clown
	name = "The Clown"
	desc = "The one and only."
	species = "human"
	sex = MALE
	gender = MALE
	dialogue_id = "clown_dialogue"

/mob/living/advanced/npc/unique/clown/Initialize()
	..()
	change_organ_visual("skin", desired_color = "#FFBAA3")
	change_organ_visual("hair_head", desired_color = "#9E7E6E", desired_icon_state = "hair_a")
	update_all_blends()
	equip_loadout(/loadout/clown)
	return .
