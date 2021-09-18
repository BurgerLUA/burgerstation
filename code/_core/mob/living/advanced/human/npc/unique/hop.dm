/mob/living/advanced/npc/unique/hop
	name = "Head of Personnel"
	desc = "All access, please."
	species = "human"
	dialogue_id = /dialogue/npc/hop/
	sex = FEMALE
	gender = FEMALE

	anchored = TRUE
	immortal = TRUE

	level = 42

/mob/living/advanced/npc/unique/hop/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#B48E7A")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon_state = "hair_long")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()
	equip_loadout(/loadout/hop)
