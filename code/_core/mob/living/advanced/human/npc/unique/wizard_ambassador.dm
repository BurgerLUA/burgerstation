/mob/living/advanced/npc/unique/wizard_ambassador
	name = "Bandalf the Right"
	desc = "Somehow, he's always right. Must be magic."
	species = "human"
	dialogue_id = /dialogue/npc/wizard_ambassador/
	sex = MALE
	gender = MALE

	anchored = TRUE
	health = null

	level = 99

/mob/living/advanced/npc/unique/wizard_ambassador/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#D8C3B8")
	change_organ_visual("hair_head", desired_color = "#E0E0E0", desired_icon_state = "hair_c")
	change_organ_visual("hair_face", desired_color = "#E0E0E0", desired_icon_state = "facial_wise")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()
	equip_loadout(/loadout/wizard_ambassador)
