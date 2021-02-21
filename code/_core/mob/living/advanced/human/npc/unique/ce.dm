/mob/living/advanced/npc/unique/ce
	name = "Chief Engineer"
	desc = "Poly's caretaker."
	species = "human"
	sex = MALE
	gender = MALE
	dialogue_id = "ce_dialogue"
	dir = EAST


/mob/living/advanced/npc/unique/ce/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#CB8D81")
	change_organ_visual("hair_head", desired_color = "#291F1D", desired_icon_state = "hair_thinningfront_s")
	change_organ_visual("hair_face", desired_color = "#291F1D", desired_icon_state = "facial_muttonmus_s")
	update_all_blends()
	equip_loadout(/loadout/chief_engineer)
	