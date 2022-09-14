/mob/living/advanced/npc/unique/cmo
	name = "Chief Medical Officer"
	desc = "Turn your head and cough."
	species = "human"
	dialogue_id = /dialogue/npc/cmo/
	sex = MALE
	gender = MALE

	anchored = TRUE
	health = null

	level = 12

	loadout = /loadout/cmo


/mob/living/advanced/npc/unique/cmo/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#D3B09E")
	change_organ_visual("hair_head", desired_color = "#7C7068", desired_icon_state = "hair_medfade_s")


/mob/living/advanced/npc/unique/cmo/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
