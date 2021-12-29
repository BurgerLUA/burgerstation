/mob/living/advanced/npc/unique/stand_user
	name = "Stand User"
	sex = FEMALE
	gender = FEMALE
	dir = EAST
	ai = /ai/advanced/

	level = 20

/mob/living/advanced/npc/unique/stand_user/Initialize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	change_organ_visual("skin", desired_color = "#B48E7A")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon_state = "hair_long")
	update_all_blends()
	equip_loadout(/loadout/hop)

	stand = new(src)
	stand.generate()
	stand.linked_stand.set_enabled(TRUE)

