/mob/living/advanced/npc/rev
	name = "revolutionary"
	enable_AI = TRUE
	ai = /ai/advanced/syndicate
	class = /class/syndicate_soldier

/mob/living/advanced/npc/rev/Initialize()

	. = ..()

	change_organ_visual("skin", desired_color = "#FFBAA3")
	change_organ_visual("hair_head", desired_color = "#9E7E6E", desired_icon_state = "hair_a")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)

	update_all_blends()

	equip_loadout(/loadout/rev)

	return .