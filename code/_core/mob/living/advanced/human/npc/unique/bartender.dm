/mob/living/advanced/npc/unique/bartender
	name = "Miss Flanagan"
	desc = "Remember the!"
	species = "human"
	gender = FEMALE
	sex = FEMALE
	dialogue_id = "bartender_dialogue"

/mob/living/advanced/npc/unique/bartender/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#E0BCAA")
	change_organ_visual("hair_head", desired_color = "#C45927", desired_icon_state = "hair_drillhair")
	update_all_blends()
	equip_loadout(/loadout/bartender/)

	return .
