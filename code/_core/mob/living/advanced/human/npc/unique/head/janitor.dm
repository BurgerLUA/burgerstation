/mob/living/advanced/npc/unique/head/janitor
	name = "Chief Sanitation Expert"
	desc = "All access, please."
	species = "human"
	dialogue_id = /dialogue/npc/hop/
	sex = MALE
	gender = MALE

	dna = /dna/human

	anchored = TRUE
	health = null

	level = 50

	loadout = /loadout/nanotrasen/head/janitor

/mob/living/advanced/npc/unique/head/janitor/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#E5B7A0")
	change_organ_visual("hair_head", desired_color = "#35271B", desired_icon_state = "hair_messy")