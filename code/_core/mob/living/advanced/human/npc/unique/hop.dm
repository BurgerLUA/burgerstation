/mob/living/advanced/npc/unique/hop
	name = "Head of Personnel"
	desc = "All access, please."
	species = "human"
	sex = FEMALE
	gender = FEMALE
	dialogue_id = "hop_dialogue"
	dir = WEST


/mob/living/advanced/npc/unique/hop/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#B48E7A")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon_state = "hair_long")
	update_all_blends()
	equip_loadout(/loadout/hop)
	return .