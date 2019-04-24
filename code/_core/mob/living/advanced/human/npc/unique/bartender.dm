/mob/living/advanced/human/npc/unique/bartender
	name = "Miss Flanagan"
	desc = "Remember the!"
	mob_species = /species/human/
	gender = FEMALE
	sex = FEMALE
	dialogue_id = "bartender_dialogue"

/mob/living/advanced/human/npc/unique/diamond_with_flaw/Initialize()
	..()
	change_organ_visual("skin", desired_color = "#E0BCAA")
	change_organ_visual("hair_head", desired_color = "#C45927")
