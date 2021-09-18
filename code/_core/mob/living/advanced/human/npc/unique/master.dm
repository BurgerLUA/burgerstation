/mob/living/advanced/npc/unique/master
	name = "Master-General of the Ordnance Mills"
	desc = "The master of everything."

	ai = /ai/advanced

	sex = MALE
	gender = MALE

	species = "stand"

	blood_type = /reagent/blood/human/ab_negative

	dialogue_id = /dialogue/npc/master

	immortal = TRUE

	anchored = TRUE

	level = 100

/mob/living/advanced/npc/unique/master/Initialize()

	. = ..()

	change_organ_visual("skin", desired_color = "#BC9E8F")

	change_organ_visual("hair_head", desired_color = "#E3D5AF", desired_icon_state = "hair_pompadour_s")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	equip_loadout(/loadout/master)

	update_all_blends()