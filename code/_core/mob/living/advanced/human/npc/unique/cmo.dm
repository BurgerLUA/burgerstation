/mob/living/advanced/npc/unique/cmo
	name = "Chief Medical Officer"
	desc = "Turn your head and cough."
	species = "human"
	dialogue_id = /dialogue/npc/cmo/
	sex = MALE
	gender = MALE

	anchored = TRUE
	immortal = TRUE

	level = 12

/mob/living/advanced/npc/unique/cmo/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#D3B09E")
	change_organ_visual("hair_head", desired_color = "#7C7068", desired_icon_state = "hair_medfade_s")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()
	equip_loadout(/loadout/cmo)
