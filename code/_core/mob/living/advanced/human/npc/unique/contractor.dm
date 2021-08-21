/mob/living/advanced/npc/unique/contractor
	name = "Mr. Scratch"
	desc = "Gives out contracts. Kinda suspicious, but NT says they're okay."

	ai = /ai/advanced

	sex = MALE
	gender = MALE

	blood_type = /reagent/blood/human/o_positive

	dialogue_id = /dialogue/npc/contractor

	immortal = TRUE

	anchored = TRUE
	density = TRUE
	size = SIZE_10

	level = 400

	var/obj/structure/interactive/vending/stored_vendor = /obj/structure/interactive/vending/contract

/mob/living/advanced/npc/unique/contractor/Initialize()

	. = ..()

	change_organ_visual("skin", desired_color = "#C6A9A9")

	change_organ_visual("eye", desired_color = "#880000")

	change_organ_visual("hair_head", desired_color = "#404040", desired_icon_state = "hair_shavedpart_s")
	change_organ_visual("hair_face", desired_color = "#404040", desired_icon_state = "facial_vandyke")

	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

	equip_loadout(/loadout/contractor)

	update_all_blends()

	if(ispath(stored_vendor))
		stored_vendor = new stored_vendor(src)
		INITIALIZE(stored_vendor)
		GENERATE(stored_vendor)
		FINALIZE(stored_vendor)