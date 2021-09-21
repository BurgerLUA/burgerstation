/mob/living/advanced/npc/unique/goblin_merchant
	name = "goblin merchant"
	desc = "Profitting from raiding settlements since 4506 BC."

	ai = /ai/advanced

	species = "goblin"

	pixel_z = -2

	blood_type = /reagent/blood/goblin

	dir = SOUTH

	dialogue_id = /dialogue/npc/goblin_merchant/

	immortal = TRUE

	anchored = TRUE

	size = SIZE_10

	level = 28

/mob/living/advanced/npc/unique/goblin_merchant/Initialize()

	. = ..()

	sex = MALE
	gender = sex

	change_organ_visual("skin", desired_color = pick("#3D6300","#425125","#4E5B0E","#686342"))

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	update_all_blends()

	equip_loadout(/loadout/goblin/merchant)