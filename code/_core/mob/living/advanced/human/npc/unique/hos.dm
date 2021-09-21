/mob/living/advanced/npc/unique/hos
	name = "Head of Security"
	desc = "Shitsec Prime."
	species = "human"
	dialogue_id = /dialogue/npc/hos/
	sex = MALE
	gender = MALE

	anchored = TRUE
	immortal = TRUE

	level = 46

/mob/living/advanced/npc/unique/hos/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#8E675C")
	change_organ_visual("hair_head", desired_color = "#6E543C", desired_icon_state = "hair_topknot_s")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()
	equip_loadout(/loadout/hos)
