/mob/living/advanced/human/npc/unique/debug
	name = "Diamond with Flaw"
	desc = "Fucking trees."
	mob_species = /species/diona/
	sex = NEUTER
	gender = MALE
	invisibility = INVISIBILITY_PLAYERS

/mob/living/advanced/human/npc/unique/debug/Initialize()
	..()
	change_organ_visual("skin", desired_color = "#BC9D58")
	change_organ_visual("skin_detail", desired_color = "#719333")
	change_organ_visual("skin_glow", desired_color = "#B2F861")
	update_all_blends()
	add_outfit("diamond_outfit")


/mob/living/advanced/human/npc/unique/debug/Cross(var/atom/moveable/A)
	return TRUE