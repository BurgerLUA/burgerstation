/mob/living/advanced/npc/unique/farmer
	name = "Crundus Bundus"
	desc = "Remember the!"
	species = "human"
	sex = MALE
	gender = MALE
	dialogue_id = "farmer_dialogue"

/mob/living/advanced/npc/unique/farmer/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#FFBAA3")
	change_organ_visual("hair_head", desired_color = "#9E7E6E", desired_icon_state = "hair_megaeyebrows")
	change_organ_visual("hair_face", desired_color = "#9E7E6E", desired_icon_state = "facial_moonshiner_s")
	update_all_blends()
	equip_loadout(/loadout/farmer)
	return .

