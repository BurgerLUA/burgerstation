/mob/living/advanced/npc/unique/head/rd
	name = "Research Director"
	desc = "Doesn't have to worry about plasmafloods here."
	species = "human"
	dialogue_id = /dialogue/npc/hop/
	sex = MALE
	gender = MALE

	dna = /dna/human

	anchored = TRUE
	health = null

	level = 50

	loadout = /loadout/nanotrasen/head/rd

/mob/living/advanced/npc/unique/head/rd/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#E0C9BE")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon_state = "hair_thinningfront")