/mob/living/advanced/npc/unique/hos
	name = "Head of Security"
	desc = "Shitsec Prime."
	species = "human"
	dialogue_id = /dialogue/npc/hos/
	sex = FEMALE
	gender = FEMALE

	dna = /dna/human

	anchored = TRUE
	health = null

	level = 46

	loadout = /loadout/hos

/mob/living/advanced/npc/unique/hos/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#B48E7A")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon_state = "hair_long")

/mob/living/advanced/npc/unique/hos/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)