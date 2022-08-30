/mob/living/advanced/npc/wizard_federation_guard
	name = "wizard federation guard"
	desc = "Investigating warcrimes since 2068."

	ai = /ai/advanced/guarding

	dialogue_id = /dialogue/npc/soldier/

	level = 16



/mob/living/advanced/npc/wizard_federation_guard/Initialize()

	. = ..()

	sex = pick(MALE,FEMALE)
	gender = sex

	change_organ_visual("skin", desired_color = pick("#E0BCAA","#BC9E8F","#967F73","#7A675E"))

	if(sex == FEMALE)
		change_organ_visual("hair_head", desired_color = "#262626", desired_icon_state = "hair_longest2")
	else
		change_organ_visual("hair_head", desired_color = "#E0E0E0", desired_icon_state = "hair_c")
		change_organ_visual("hair_face", desired_color = "#E0E0E0", desired_icon_state = "facial_wise")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()

	equip_loadout(/loadout/wizard_guard)

