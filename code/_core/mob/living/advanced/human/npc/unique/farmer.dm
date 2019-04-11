/mob/living/advanced/human/npc/unique/farmer
	name = "Crundus Bundus"
	desc = "Remember the!"
	mob_species = /species/human/
	sex = MALE
	gender = MALE
	dialogue_id = "farmer_dialogue"

/mob/living/advanced/human/npc/unique/diamond_with_flaw/Initialize()
	..()
	change_organ_visual("skin", desired_color = "#FFBAA3")
	change_organ_visual("hair_head", desired_color = "#9E7E6E")
	change_organ_visual("hair_face", desired_color = "#9E7E6E")
	update_all_blends()

