/mob/living/advanced/npc/unique/robust
	name = "Ultimate Being"
	desc = "The most robust man in the world."
	species = "human"
	sex = MALE
	gender = MALE
	class = "robust"
	ai = /ai/advanced/

/mob/living/advanced/npc/unique/robust/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#FFBAA3")
	change_organ_visual("hair_head", desired_color = "#9E7E6E")
	change_organ_visual("hair_face", desired_color = "#9E7E6E")
	update_all_blends()
	return .

