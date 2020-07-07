/mob/living/advanced/npc/unique/shopkeeper
	name = "Shopkeeper Eric"
	desc = "Some may call this junk, me, I call them treasures."
	species = "human"
	sex = MALE
	gender = MALE
	dialogue_id = "shopkeeper_dialogue"

/mob/living/advanced/npc/unique/shopkeeper/Initialize()
	..()
	change_organ_visual("skin", desired_color = "#FFBAA3")
	change_organ_visual("hair_head", desired_color = "#9E7E6E", desired_icon_state = "hair_a")
	//change_organ_visual("hair_face", desired_color = "#9E7E6E")
	update_all_blends()
	equip_loadout(/loadout/shopkeeper/)
	return .
