/mob/living/advanced/npc/unique/bar_shaleez
	name = "Bar-Shaleez"
	species = "reptile_advanced"
	sex = FEMALE
	gender = FEMALE
	dir = EAST
	ai = /ai/advanced/

/mob/living/advanced/npc/unique/bar_shaleez/Initialize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty)
	change_organ_visual("skin", desired_color = "#779922")
	change_organ_visual("eyes", desired_color = "#F2F200")
	change_organ_visual("hair_head", desired_color = "#779922", desired_icon_state = "frills_short")
	update_all_blends()
	equip_loadout(/loadout/shaleez)
	return .