/mob/living/advanced/npc/unique/head/cmo
	name = "Chief Medical Officer"
	desc = "Turn your head and cough."
	species = "human"
	dialogue_id = /dialogue/npc/chief_medical_officer
	sex = MALE
	gender = MALE

	dna = /dna/human

	anchored = TRUE
	health = null

	level = 50

	loadout = /loadout/nanotrasen/head/cmo


/mob/living/advanced/npc/unique/head/cmo/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#D3B09E")
	change_organ_visual("hair_head", desired_color = "#7C7068", desired_icon_state = "hair_medfade")